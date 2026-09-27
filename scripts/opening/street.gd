extends Node2D
const Actor := preload("res://scripts/opening/actor.gd")
const Resident := preload("res://scripts/opening/resident.gd")
var player: CharacterBody2D
var camera: Camera2D
var foreground: Sprite2D
var residents: Array = []
var data: Dictionary
var enabled := false
var camera_x := 272.0
var backdrop: Sprite2D

func _ready() -> void:
	data = JSON.parse_string(FileAccess.get_file_as_string("res://data/opening/village.json"))
	backdrop = Sprite2D.new()
	backdrop.texture = preload("res://assets/opening/staging_v3/street_stage.png")
	backdrop.centered = false
	var stage_shader := Shader.new()
	stage_shader.code = "shader_type canvas_item; void fragment() { vec4 center = texture(TEXTURE, UV); vec3 accum = vec3(0.0); float total = 0.0; for (int y = -1; y <= 1; y++) { for (int x = -1; x <= 1; x++) { vec3 sample_color = texture(TEXTURE, UV + vec2(float(x), float(y)) * TEXTURE_PIXEL_SIZE).rgb; vec3 difference = sample_color - center.rgb; float weight = exp(-dot(difference, difference) * 48.0); accum += sample_color * weight; total += weight; } } vec3 clean = accum / total; COLOR = vec4(floor(clean * 28.0 + vec3(0.5)) / 28.0, center.a); }"
	var stage_material := ShaderMaterial.new()
	stage_material.shader = stage_shader
	backdrop.material = stage_material
	add_child(backdrop)
	var cast := Node2D.new()
	cast.y_sort_enabled = true
	add_child(cast)
	player = Actor.new()
	player.name = "Akira"
	player.controlled = true
	player.position = Vector2(data.spawn[0],data.spawn[1])
	cast.add_child(player)
	for spec in data.npc:
		var resident := Resident.new()
		resident.name = spec.id
		resident.row = spec.row
		resident.atlas = load(spec.atlas)
		resident.look_left_frame = spec.look_left_frame
		resident.look_right_frame = spec.look_right_frame
		resident.mirror_left_look = spec.mirror_left_look
		resident.behavior = spec.mode
		resident.roam_range = spec.range
		resident.walk_speed = spec.speed
		resident.phrase = spec.phrase
		resident.position = Vector2(spec.position[0],spec.position[1])
		resident.player = player
		cast.add_child(resident)
		residents.append(resident)
	foreground = Sprite2D.new()
	foreground.texture = preload("res://assets/opening/staging_v3/foreground_close_REVIEW.png")
	foreground.centered = false
	foreground.position.y = 335
	foreground.region_enabled = true
	foreground.region_rect = Rect2(0,0,808,48)
	foreground.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	foreground.z_index = 20
	add_child(foreground)
	# Physical boundaries prevent access to stairs, distant bridge and lower void.
	add_wall(Vector2(420,282),Vector2(700,12))
	add_wall(Vector2(420,355),Vector2(700,12))
	add_wall(Vector2(99,319),Vector2(12,85))
	add_wall(Vector2(746,319),Vector2(12,85))
	camera = Camera2D.new()
	camera.position = Vector2(272,268)
	camera.zoom = Vector2(2.0,2.0)
	camera.position_smoothing_enabled = false
	add_child(camera)
	camera.make_current()

func add_wall(at: Vector2, size: Vector2) -> void:
	var body := StaticBody2D.new()
	body.position = at
	body.collision_layer = 2
	body.collision_mask = 0
	var shape := CollisionShape2D.new()
	var rect := RectangleShape2D.new()
	rect.size = size
	shape.shape = rect
	body.add_child(shape)
	add_child(body)

func _physics_process(delta: float) -> void:
	var target := clampf(player.position.x,272,640)
	camera_x = move_toward(camera_x,target,92*delta)
	camera.position.x = roundf(camera_x)
	foreground.position.x = -roundf((camera_x-272)*0.02)
	# A shallow lane gives restrained size change while keeping every actor adult-proportioned.
	player.scale = Vector2.ONE * lane_scale(player.position.y)
	for resident in residents:
		resident.scale = Vector2.ONE * lane_scale(resident.position.y)

func lane_scale(feet_y: float) -> float:
	return lerpf(0.93,1.06,clampf((feet_y-294.0)/50.0,0.0,1.0))


func enable_control() -> void:
	enabled = true
	player.input_enabled = true
