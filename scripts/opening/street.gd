extends Node2D
const Actor := preload("res://scripts/opening/actor.gd")
const Resident := preload("res://scripts/opening/resident.gd")
var player: CharacterBody2D
var camera: Camera2D
var foreground: Sprite2D
var residents: Array = []
var data: Dictionary
var enabled := false
var camera_x := 542.0
var backdrop: Sprite2D
const STREET_WIDTH := 1085.0

func _ready() -> void:
	data = JSON.parse_string(FileAccess.get_file_as_string("res://data/opening/village.json"))
	backdrop = Sprite2D.new()
	backdrop.texture = preload("res://assets/opening/village_target_v4/street_clean_source_REVIEW.png")
	backdrop.centered = false
	backdrop.scale = Vector2.ONE * 0.5
	backdrop.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
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
	# Reuse only the painted lower rail areas above the cast for pixel-exact
	# foreground occlusion. The plate remains the source of truth for color.
	foreground = Sprite2D.new()
	foreground.texture = backdrop.texture
	foreground.centered = false
	foreground.scale = backdrop.scale
	foreground.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	foreground.z_index = 20
	var rail_shader := Shader.new()
	rail_shader.code = "shader_type canvas_item; void fragment() { vec2 p = UV * vec2(2170.0, 725.0); bool left_rail = p.x < 810.0 && p.y > 480.0 + 0.30 * p.x; bool right_rail = p.x > 1250.0 && p.y > 450.0 + 0.34 * (p.x - 1250.0); if (!left_rail && !right_rail) discard; COLOR = texture(TEXTURE, UV); }"
	var rail_material := ShaderMaterial.new()
	rail_material.shader = rail_shader
	foreground.material = rail_material
	add_child(foreground)
	# Feet remain on the converging stone lane; roofs and steps are not walkable.
	camera = Camera2D.new()
	camera.position = Vector2(camera_x,180)
	camera.zoom = Vector2.ONE
	camera.position_smoothing_enabled = false
	add_child(camera)
	camera.make_current()

func _physics_process(delta: float) -> void:
	var target := clampf(player.position.x,320,STREET_WIDTH-320)
	camera_x = move_toward(camera_x,target,140*delta)
	camera.position.x = roundf(camera_x)
	# The lane recedes into the image. Scale follows the foot position in depth.
	player.scale = Vector2.ONE * lane_scale(player.position.y)
	for resident in residents:
		resident.scale = Vector2.ONE * lane_scale(resident.position.y)

func lane_scale(feet_y: float) -> float:
	return lerpf(1.20,2.25,clampf((feet_y-90.0)/245.0,0.0,1.0))

func lane_limits(feet_y: float) -> Vector2:
	var depth := clampf((feet_y-80.0)/260.0,0.0,1.0)
	return Vector2(lerpf(465,375,depth),lerpf(615,650,depth))


func enable_control() -> void:
	enabled = true
	player.input_enabled = true
