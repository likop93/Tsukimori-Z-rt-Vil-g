extends Node2D
const IDLE := preload("res://assets/opening/staging_v3/akira_atlas.png")
const WALK := preload("res://assets/opening/gait_v5/side_atlas_REVIEW.png")
var actor: Sprite2D
var bus: Sprite2D
var door: Sprite2D
var foreground: Sprite2D
var mode := ""
var clock := 0.0
var memory_material: ShaderMaterial
var clips: Array = []
var clip_index := -1
var texture_cache: Dictionary = {}
var watchers: Array[Sprite2D] = []

func _ready() -> void:
	bus = Sprite2D.new()
	bus.texture = load("res://assets/opening/short_intro_v1/bus_REVIEW.png")
	bus.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	bus.scale = Vector2.ONE * (420.0 / bus.texture.get_width())
	add_child(bus)
	# Separate door layer: slide it open before Akira steps down.
	var size := bus.texture.get_size()
	var region := Rect2(size*Vector2(0.16,0.325),size*Vector2(0.078,0.46))
	var dark := Polygon2D.new()
	var origin := region.position-size/2
	dark.polygon = PackedVector2Array([origin,origin+Vector2(region.size.x,0),origin+region.size,origin+Vector2(0,region.size.y)])
	dark.color = Color("#171a25")
	bus.add_child(dark)
	door = Sprite2D.new()
	door.texture = bus.texture
	door.region_enabled = true
	door.region_rect = region
	door.centered = false
	door.position = origin
	bus.add_child(door)
	actor = Sprite2D.new()
	actor.hframes = 4
	actor.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	actor.scale = Vector2.ONE * 1.25
	add_child(actor)
	for i in 2:
		var watcher := Sprite2D.new()
		watcher.texture = load("res://assets/opening/generated/npc_v2/resident_0"+str(i+1)+"_atlas.png")
		watcher.hframes = 4
		watcher.vframes = 2
		watcher.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		watcher.scale = Vector2.ONE*0.45
		watcher.position = Vector2(548+i*32,229)
		watcher.modulate = Color(0.45,0.47,0.6,0.8)
		add_child(watcher)
		watchers.append(watcher)
	foreground = Sprite2D.new()
	foreground.texture = load("res://assets/opening/short_intro_v1/forest_gate_REVIEW.png")
	foreground.centered = false
	foreground.scale = Vector2(640,360)/foreground.texture.get_size()
	foreground.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	foreground.z_index = 2
	var leaf_shader := Shader.new()
	leaf_shader.code = "shader_type canvas_item; void fragment(){ if(UV.y<0.86) discard; COLOR=texture(TEXTURE,UV); }"
	var leaf_material := ShaderMaterial.new()
	leaf_material.shader = leaf_shader
	foreground.material = leaf_material
	add_child(foreground)
	var shader := Shader.new()
	shader.code = "shader_type canvas_item; uniform float fracture=0.0; uniform float time=0.0; void fragment(){ vec2 uv=UV; uv.x+=sin(floor(uv.y*24.0)*4.0+time*2.0)*fracture*0.007; vec4 c=texture(TEXTURE,clamp(uv,vec2(0),vec2(1))); COLOR=c; }"
	memory_material = ShaderMaterial.new()
	memory_material.shader = shader
	reset_stage()

func configure(beat: Dictionary) -> void:
	clips = beat.get("cuts",[])
	clip_index = -1
	for clip in clips:
		if not texture_cache.has(clip.asset):
			texture_cache[clip.asset] = load(clip.asset)

func reset_stage() -> void:
	position = Vector2.ZERO
	scale = Vector2.ONE
	if actor != null:
		actor.scale = Vector2.ONE * 1.25
		actor.hide()
		bus.hide()
		foreground.hide()
		for watcher in watchers:
			watcher.hide()
	mode = ""
	queue_redraw()

func pose(at: Vector2, moving: bool, distance: float) -> void:
	actor.show()
	actor.texture = WALK if moving else IDLE
	actor.vframes = 2 if moving else 4
	actor.frame = int(distance/(24.0*actor.scale.x)*8.0)%8 if moving else 3
	actor.position = at-Vector2(0,46*actor.scale.y)

func update_cuts(time: float, shot: TextureRect) -> void:
	if clips.is_empty():
		return
	var index := 0
	for i in clips.size():
		if time >= float(clips[i].at):
			index = i
	var clip: Dictionary = clips[index]
	if index != clip_index:
		clip_index = index
		var texture: Texture2D = texture_cache[clip.asset]
		if clip.has("crop"):
			var c: Array = clip.crop
			var atlas := AtlasTexture.new()
			atlas.atlas = texture
			atlas.region = Rect2(Vector2(c[0],c[1])*texture.get_size(),Vector2(c[2],c[3])*texture.get_size())
			texture = atlas
		shot.texture = texture
	var local_time := time-float(clip.at)
	var zoom := 1.0+minf(local_time,4.0)*float(clip.get("push",0.01))
	shot.scale = Vector2.ONE*zoom
	shot.position = Vector2(320,180)*(1-zoom)
	memory_material.set_shader_parameter("fracture",float(clip.get("fracture",0)))
	memory_material.set_shader_parameter("time",time)

func update_stage(id: String, time: float, duration: float, shot: TextureRect) -> void:
	mode = id
	clock = time
	match id:
		"bus":
			var push := 1.0+0.07*smoothstep(0,duration,time)
			shot.scale = Vector2.ONE*push
			shot.position = Vector2(-180,-150)*(push-1)+Vector2(0,roundf(sin(time*1.5)))
		"memory":
			shot.material = memory_material
			update_cuts(time,shot)
			# Deliberate black interruption, not a rapid strobe.
			var blackout := (time>6.5 and time<6.8) or time>10.9
			shot.modulate.a = 0.0 if blackout else 1.0
		"recover":
			var recoil := exp(-time*3.0)
			shot.scale = Vector2.ONE*(1.03+0.025*recoil)
			shot.position = Vector2(-10,-5)+Vector2(3*sin(time*12)*recoil,0)
		"stop":
			bus.show()
			var departure := maxf(0,time-5)
			bus.position = Vector2(225-departure*departure*45,205)
			var open_amount := smoothstep(0.5,1.3,time)*(1-smoothstep(4.3,4.8,time))
			door.scale.x = lerpf(1,0.08,open_amount)
			if time >= 1.4:
				var descent := smoothstep(1.4,2.3,time)
				var walk := clampf(time-2.3,0,2.7)
				pose(Vector2(95+walk*35.55,lerpf(257,282,descent)),time<5,walk*35.55+descent*15)
				actor.modulate.a = smoothstep(1.4,1.7,time)
		"forest":
			actor.modulate.a = 1
			var track := smoothstep(0,duration,time)
			scale = Vector2.ONE*lerpf(1,1.14,track)
			position = Vector2(-70,-32)*track
			shot.scale = scale
			shot.position = position
			pose(Vector2(191+time*23,279),true,96+time*23)
			foreground.show()
			foreground.position.x = -3*track
			for watcher in watchers:
				watcher.show()
				watcher.frame = 3 if time>6 else 0
		"gate":
			actor.modulate.a = 1
			var approach := smoothstep(0,4,time)
			scale = Vector2.ONE * lerpf(1.14,1.35,approach)
			position = Vector2(-70,-32).lerp(Vector2(-224,-80),approach)
			shot.scale = scale
			shot.position = position
			actor.scale = Vector2.ONE * lerpf(1.25,1.55,approach)
			var distance := minf(time,2.0)*23
			pose(Vector2(467+distance,279),time<2,372+distance)
			foreground.show()
			foreground.position.x = -3-3*approach
			for watcher in watchers:
				watcher.show()
				watcher.frame = 3
	queue_redraw()

func _draw() -> void:
	if actor != null and actor.visible:
		draw_set_transform(actor.position+Vector2(0,46*actor.scale.y),0,Vector2(1,0.25))
		draw_circle(Vector2.ZERO,12,Color(0.02,0.025,0.04,0.45))
		draw_set_transform(Vector2.ZERO)
	if mode == "bus" or mode == "recover":
		# Window-only droplets and travelling light; no rain inside the cabin.
		for i in 25:
			var x := 443+fposmod(i*29.0-clock*2,190)
			var y := 24+fposmod(i*37.0+clock*(11+i%4),219)
			draw_line(Vector2(x,y).round(),Vector2(x-1,y+5).round(),Color(0.6,0.76,0.95,0.20),1)
		for i in 3:
			var x := 436+fposmod(clock*26+i*71,194)
			draw_rect(Rect2(x,35,3,197),Color(1,0.64,0.32,0.09))
	if mode in ["forest","gate"]:
		for i in 8:
			var x := fposmod(i*98.0-clock*7,760)-90
			draw_rect(Rect2(x,236+i%3*9,110,2),Color(0.6,0.7,0.85,0.06))
