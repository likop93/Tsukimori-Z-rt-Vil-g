extends Node2D
const Actor := preload("res://scripts/opening/actor.gd")
const Resident := preload("res://scripts/opening/resident.gd")
var player: CharacterBody2D
var camera: Camera2D
var foreground: Sprite2D
var residents: Array = []
var data: Dictionary
var enabled := false
var camera_locked := true
var camera_x := 542.0
var backdrop: Sprite2D
var location := "street"
var bridge_rail: Node2D
const BRIDGE_PATH := [Vector2(65,188),Vector2(185,187),Vector2(265,177),Vector2(345,178),Vector2(435,189),Vector2(555,205)]
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
	if location != "street":
		return
	if not camera_locked:
		var target := clampf(player.position.x,320,STREET_WIDTH-320)
		camera_x = move_toward(camera_x,target,140*delta)
	camera.position.x = roundf(camera_x)
	# The lane recedes into the image. Scale follows the foot position in depth.
	player.scale = Vector2.ONE * lane_scale(player.position.y)
	for resident in residents:
		resident.scale = Vector2.ONE * lane_scale(resident.position.y)

func lane_scale(feet_y: float) -> float:
	if location != "street":
		return 1.3
	return lerpf(1.20,2.25,clampf((feet_y-90.0)/245.0,0.0,1.0))

func lane_limits(feet_y: float) -> Vector2:
	if location != "street":
		return Vector2(65,555) if location == "bridge" else Vector2(110,545)
	var depth := clampf((feet_y-80.0)/260.0,0.0,1.0)
	return Vector2(lerpf(465,375,depth),lerpf(615,650,depth))

func constrain_position(at: Vector2) -> Vector2:
	if location == "bridge":
		at.x = clampf(at.x,65,555)
		for i in range(1,BRIDGE_PATH.size()):
			var end: Vector2 = BRIDGE_PATH[i]
			var start: Vector2 = BRIDGE_PATH[i-1]
			if at.x <= end.x:
				at.y = lerpf(start.y,end.y,(at.x-start.x)/(end.x-start.x))
				break
		return at
	# Stop before the upper village steps and keep the house feet between
	# the planted border and the near fence, including during cinematics.
	at.y = clampf(at.y,150 if location == "street" else 264,339 if location == "street" else 282)
	var edges := lane_limits(at.y)
	at.x = clampf(at.x,edges.x,edges.y)
	return at

func add_rail_patch(points: PackedVector2Array) -> void:
	var patch := Polygon2D.new()
	patch.polygon = points
	var texcoords := PackedVector2Array()
	for point in points:
		texcoords.append(point*Vector2(backdrop.texture.get_width()/640.0,backdrop.texture.get_height()/360.0))
	patch.uv = texcoords
	patch.texture = backdrop.texture
	patch.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	bridge_rail.add_child(patch)

func build_bridge_rail() -> void:
	bridge_rail = Node2D.new()
	bridge_rail.z_index = 20
	add_child(bridge_rail)
	# Exact source-image patches put the near rail in front of the actor.
	add_rail_patch(PackedVector2Array([Vector2(190,179),Vector2(265,174),Vector2(345,174),Vector2(435,184),Vector2(544,201),Vector2(544,212),Vector2(435,196),Vector2(345,186),Vector2(265,185),Vector2(190,191)]))
	for post in [Rect2(248,151,10,36),Rect2(361,157,9,31),Rect2(486,166,11,37),Rect2(535,181,10,32)]:
		add_rail_patch(PackedVector2Array([post.position,post.position+Vector2(post.size.x,0),post.end,post.position+Vector2(0,post.size.y)]))

func show_location(next_location: String) -> void:
	location = next_location
	for resident in residents:
		resident.hide()
		resident.set_physics_process(false)
	foreground.hide()
	if is_instance_valid(bridge_rail):
		bridge_rail.hide()
	var file := "BRIDGE_PIXEL_V1.png" if location == "bridge" else "MIYAKO_HOUSE_EXTERIOR_PIXEL_V1.png"
	backdrop.texture = load("res://assets/opening/reference/"+file)
	backdrop.scale = Vector2(640.0/backdrop.texture.get_width(),360.0/backdrop.texture.get_height())
	if location == "bridge":
		if not is_instance_valid(bridge_rail):
			build_bridge_rail()
		bridge_rail.show()
	camera.position = Vector2(320,180)
	camera_x = 320
	player.velocity = Vector2.ZERO
	player.scripted_axis = Vector2.ZERO
	player.scale = Vector2.ONE * (1.1 if location == "bridge" else 1.55)
	player.floor_min = 170 if location == "bridge" else 260
	player.floor_max = 205 if location == "bridge" else 286
	player.position = Vector2(85,190) if location == "bridge" else Vector2(145,274)
	player.facing = 3
	# Anonymous women remain at the edges of each arrival composition.
	# Their look frames track Akira, including when he crosses their sightline.
	var placements := [Vector2(130,173),Vector2(560,204)] if location == "bridge" else [Vector2(120,247),Vector2(525,246)]
	for i in placements.size():
		var resident: Node2D = residents[i]
		resident.position = placements[i]
		resident.home_x = resident.position.x
		resident.scale = Vector2.ONE * (0.85 if location == "bridge" else 1.1)
		resident.watch_arrival = true
		resident.show()
		resident.set_physics_process(true)


func enable_control() -> void:
	enabled = true
	camera_locked = false
	player.input_enabled = true
