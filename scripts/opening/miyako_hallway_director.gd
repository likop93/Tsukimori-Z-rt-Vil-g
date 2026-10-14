extends CanvasLayer
## Optional REVIEW insert. All motion is driven by a pausable Godot animation.
signal completed
const SEEN := "miyako_hallway_glimpse_seen"
var runner: Node
var animation: AnimationPlayer
var camera: Camera2D
var light: PointLight2D
var cue: AudioStreamPlayer
var vn: CanvasLayer
var poses: Array[Sprite2D] = []
var started := false
var finished := false
var turn := 0.0:
	set(value):
		turn = value
		update_pose()
var smile := 0.0:
	set(value):
		smile = value
		update_pose()
var blink := 0.0:
	set(value):
		blink = value
		update_pose()

func begin() -> bool:
	if started or GameState.has_flag(SEEN):
		return false
	started = true
	layer = 27
	process_mode = Node.PROCESS_MODE_PAUSABLE
	build_stage()
	build_animation()
	animation.play("hallway")
	return true

func build_stage() -> void:
	var display := SubViewportContainer.new()
	display.size = Vector2(640,360)
	display.mouse_filter = Control.MOUSE_FILTER_IGNORE
	display.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	add_child(display)
	var viewport := SubViewport.new()
	viewport.size = Vector2i(640,360)
	viewport.world_2d = World2D.new()
	viewport.handle_input_locally = false
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	display.add_child(viewport)
	var world := Node2D.new()
	viewport.add_child(world)
	var backdrop := Sprite2D.new()
	backdrop.texture = load("res://assets/home_day1/hallway/hallway_night_v1_REVIEW.png")
	backdrop.centered = false
	backdrop.scale = Vector2(640.0/backdrop.texture.get_width(),360.0/backdrop.texture.get_height())
	world.add_child(backdrop)
	var shade := CanvasModulate.new()
	shade.color = Color(0.68,0.71,0.82)
	world.add_child(shade)
	# Floor contact stays fixed through every pose; transparent source is intact.
	var shadow := Polygon2D.new()
	var outline := PackedVector2Array()
	for i in 32:
		outline.append(Vector2(cos(i*TAU/32)*19,sin(i*TAU/32)*3))
	shadow.polygon = outline
	shadow.position = Vector2(371,252)
	shadow.color = Color(0.015,0.012,0.025,0.48)
	world.add_child(shadow)
	var source := load("res://assets/home_day1/hallway/miyako_turn_v1_REVIEW.png") as Texture2D
	var source_image := source.get_image()
	# Generated source has uneven gutters: explicit non-overlapping cells.
	var edges := [0,460,820,1170,1540,1983]
	for i in 5:
		var cell := Rect2i(edges[i],0,edges[i+1]-edges[i],source.get_height())
		var bounds := source_image.get_region(cell).get_used_rect()
		var texture := AtlasTexture.new()
		texture.atlas = source
		texture.region = Rect2(bounds.position+cell.position,bounds.size)
		var pose := Sprite2D.new()
		pose.texture = texture
		pose.centered = false
		pose.offset = Vector2(-bounds.size.x*0.5,-bounds.size.y)
		pose.scale = Vector2.ONE*(146.0/bounds.size.y)
		pose.position = Vector2(371,252)
		world.add_child(pose)
		poses.append(pose)
	update_pose()
	light = PointLight2D.new()
	light.position = Vector2(358,163)
	var gradient := Gradient.new()
	gradient.colors = PackedColorArray([Color(1,1,1,0.45),Color(1,1,1,0)])
	var glow := GradientTexture2D.new()
	glow.gradient = gradient
	glow.width = 256
	glow.height = 256
	glow.fill = GradientTexture2D.FILL_RADIAL
	glow.fill_from = Vector2(0.5,0.5)
	glow.fill_to = Vector2(1,0.5)
	light.texture = glow
	light.color = Color(1.0,0.71,0.40)
	light.energy = 0.35
	world.add_child(light)
	camera = Camera2D.new()
	camera.position = Vector2(320,180)
	world.add_child(camera)
	camera.make_current()
	cue = AudioStreamPlayer.new()
	cue.stream = runner.ambience.make_effect("wood")
	cue.volume_db = -27
	add_child(cue)
	var caption := Label.new()
	caption.name = "Caption"
	caption.text = "Közös otthon · folyosó   /   REVIEW"
	caption.position = Vector2(20,18)
	caption.add_theme_font_size_override("font_size",12)
	caption.modulate = Color(0.8,0.76,0.69)
	add_child(caption)

func update_pose() -> void:
	if poses.size() != 5:
		return
	# Keep an opaque lower pose while the next layer fades in. Fading both
	# would make the ordinary character look ghostlike against the hallway.
	var weights := [1.0 if turn < 1.0 else 0.0, clampf(turn,0,1) if turn < 2.0 else 0.0,clampf(turn-1,0,1),smile,blink]
	for i in 5:
		poses[i].modulate.a = weights[i]

func track(clip: Animation, target: Node, property: String, keys: Array, discrete := false) -> void:
	var index := clip.add_track(Animation.TYPE_VALUE)
	clip.track_set_path(index,NodePath(str(get_path_to(target))+":"+property))
	if discrete:
		clip.value_track_set_update_mode(index,Animation.UPDATE_DISCRETE)
	for key in keys:
		clip.track_insert_key(index,key[0],key[1])

func build_animation() -> void:
	animation = AnimationPlayer.new()
	add_child(animation)
	var clip := Animation.new()
	clip.length = 16.0
	track(clip,camera,"position",[[0,Vector2(320,180)],[3,Vector2(330,180)],[11,Vector2(330,180)],[13,Vector2(333,177)],[16,Vector2(333,177)]])
	track(clip,camera,"zoom",[[0,Vector2.ONE],[3,Vector2(1.025,1.025)],[11,Vector2(1.025,1.025)],[13,Vector2(1.085,1.085)],[16,Vector2(1.085,1.085)]])
	track(clip,self,"turn",[[0,0.0],[3,0.0],[5,1.0],[7,2.0],[16,2.0]])
	track(clip,self,"smile",[[0,0.0],[11,0.0],[12,0.65],[13,0.65],[13.3,0.0],[16,0.0]])
	track(clip,self,"blink",[[0,0.0],[13.55,0.0],[13.63,1.0],[13.73,1.0],[13.83,0.0],[16,0.0]])
	# One restrained lighting hesitation, no weather or transformed shadow sprite.
	track(clip,light,"energy",[[0,0.35],[11.8,0.35],[11.94,0.19],[12.12,0.35],[16,0.35]])
	track(clip,get_node("Caption"),"modulate:a",[[0,1.0],[2,1.0],[3,0.0],[16,0.0]])
	var sound := clip.add_track(Animation.TYPE_METHOD)
	clip.track_set_path(sound,NodePath("."))
	clip.track_insert_key(sound,0.4,{"method":"play_creak","args":[]})
	var library := AnimationLibrary.new()
	library.add_animation("hallway",clip)
	animation.add_animation_library("",library)
	animation.animation_finished.connect(on_animation_finished)

func play_creak() -> void:
	cue.play()

func on_animation_finished(_name: StringName) -> void:
	if finished or is_instance_valid(vn):
		return
	vn = preload("res://scripts/ui/vn_dialogue.gd").new()
	add_child(vn)
	vn.finished.connect(finish)
	# Keep the live hallway visible. The existing VN owns text and input.
	vn.begin(JSON.parse_string(FileAccess.get_file_as_string("res://data/home_day1/miyako_hallway_REVIEW.json")))

func finish() -> void:
	if finished:
		return
	finished = true
	GameState.set_flag(SEEN)
	cue.stop()
	hide()
	completed.emit()
	queue_free()
