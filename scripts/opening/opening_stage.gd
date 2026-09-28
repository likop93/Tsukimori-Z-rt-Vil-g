extends Node2D
const IDLE := preload("res://assets/opening/staging_v3/akira_atlas.png")
const WALK := preload("res://assets/opening/gait_v5/side_atlas_REVIEW.png")
var actor: Sprite2D
var bus: Sprite2D
var mode := ""
var clock := 0.0
var memory_material: ShaderMaterial
func _ready() -> void:
	bus = Sprite2D.new()
	bus.texture = load("res://assets/opening/short_intro_v1/bus_REVIEW.png")
	bus.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	bus.scale = Vector2.ONE * (420.0 / bus.texture.get_width())
	add_child(bus)
	actor = Sprite2D.new()
	actor.hframes = 4
	actor.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	actor.scale = Vector2.ONE * 1.25
	add_child(actor)
	var shader := Shader.new()
	shader.code = "shader_type canvas_item; uniform float fracture = 0.0; uniform float time = 0.0; void fragment(){ vec2 uv=UV; uv.x += sin(floor(uv.y*24.0)*4.0+time*2.0)*fracture*0.009; vec4 c=texture(TEXTURE,clamp(uv,vec2(0.0),vec2(1.0))); float gray=dot(c.rgb,vec3(0.299,0.587,0.114)); vec3 cold=mix(vec3(gray)*vec3(0.40,0.53,0.73),c.rgb,0.15); COLOR=vec4(mix(c.rgb,cold,fracture),c.a); }"
	memory_material = ShaderMaterial.new()
	memory_material.shader = shader
	reset_stage()
func reset_stage() -> void:
	position = Vector2.ZERO
	scale = Vector2.ONE
	if actor != null:
		actor.scale = Vector2.ONE * 1.25
		actor.hide()
		bus.hide()
	mode = ""
	queue_redraw()
func pose(at: Vector2, moving: bool, distance: float) -> void:
	actor.show()
	actor.texture = WALK if moving else IDLE
	actor.vframes = 2 if moving else 4
	actor.frame = int(distance/(24.0*actor.scale.x)*8.0)%8 if moving else 3
	actor.position = at-Vector2(0,46*actor.scale.y)
func update_stage(id: String, time: float, duration: float, shot: TextureRect) -> void:
	mode = id
	clock = time
	match id:
		"bus":
			shot.scale = Vector2.ONE*1.02
			shot.position = Vector2(-6+roundf(sin(time*0.45)*2),-3)
		"memory":
			shot.material = memory_material
			memory_material.set_shader_parameter("fracture",smoothstep(4.0,8.0,time))
			memory_material.set_shader_parameter("time",time)
			shot.modulate.a = 1.0-smoothstep(duration-1.0,duration,time)
		"stop":
			bus.show()
			bus.position = Vector2(225-maxf(0,time-4.0)*135,205)
			var walk_time := clampf(time-1.0,0,3.0)
			if time >= 1:
				pose(Vector2(110+walk_time*27,282),time < 4,walk_time*27)
		"forest":
			pose(Vector2(80+time*23,279),true,time*23)
		"gate":
			var approach := smoothstep(0,4,time)
			scale = Vector2.ONE * lerpf(1,1.35,approach)
			position = Vector2(-224,-80)*approach
			shot.scale = scale
			shot.position = position
			actor.scale = Vector2.ONE * lerpf(1.25,1.55,approach)
			var distance := minf(time,4.0)*22
			pose(Vector2(425+distance,279),time < 4,distance)
	queue_redraw()
func _draw() -> void:
	if actor != null and actor.visible:
		draw_set_transform(actor.position+Vector2(0,46*actor.scale.y),0,Vector2(1,0.25))
		draw_circle(Vector2.ZERO,12,Color(0.02,0.025,0.04,0.45))
		draw_set_transform(Vector2.ZERO)
	if mode == "bus":
		for i in 3:
			var x := 430+fposmod(clock*22+i*71,210)
			draw_rect(Rect2(x,32,3,205),Color(1,0.64,0.32,0.06))
