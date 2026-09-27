extends Node2D
const Actor := preload("res://scripts/opening/actor.gd")
const Resident := preload("res://scripts/opening/resident.gd")
var player: CharacterBody2D
var camera: Camera2D
var foreground: Sprite2D
var residents: Array = []
var data: Dictionary
var enabled := false
var camera_x := 320.0
var backdrop: Sprite2D

func _ready() -> void:
	data = JSON.parse_string(FileAccess.get_file_as_string("res://data/opening/village.json"))
	backdrop = Sprite2D.new()
	backdrop.texture = preload("res://assets/opening/staging_v3/street_stage.png")
	backdrop.centered = false
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
	foreground.texture = preload("res://assets/opening/staging_v3/foreground.png")
	foreground.centered = false
	foreground.position.y = 383
	foreground.region_enabled = true
	foreground.region_rect = Rect2(0,0,808,67)
	foreground.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	foreground.z_index = 20
	add_child(foreground)
	# Physical boundaries prevent access to stairs, distant bridge and lower void.
	add_wall(Vector2(420,311),Vector2(700,12))
	add_wall(Vector2(420,388),Vector2(700,12))
	add_wall(Vector2(99,342),Vector2(12,100))
	add_wall(Vector2(746,342),Vector2(12,100))
	camera = Camera2D.new()
	camera.position = Vector2(320,225)
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
	var target := clampf(player.position.x,320,480)
	camera_x = move_toward(camera_x,target,70*delta)
	camera.position.x = roundf(camera_x)
	foreground.position.x = -roundf((camera_x-320)*0.02)


func enable_control() -> void:
	enabled = true
	player.input_enabled = true
