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
var house_rail: Node2D
var featured_actor: Node2D
var kuroe_cameo: Node2D
var quiet_cameos: Array[Node2D] = []
const BRIDGE_PATH := [Vector2(75,191),Vector2(185,190),Vector2(265,181),Vector2(345,182),Vector2(435,192),Vector2(555,205)]
# Surveyed inner road edges; add the actor's foot clearance before clamping.
const STREET_EDGES := [Vector3(150,440,630),Vector3(215,410,655),Vector3(270,415,655),Vector3(339,395,680)]
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
	player.street = self
	player.name = "Akira"
	player.controlled = true
	player.position = Vector2(data.spawn[0],data.spawn[1])
	cast.add_child(player)
	kuroe_cameo = preload("res://scripts/opening/kuroe_cameo.gd").new()
	kuroe_cameo.street = self
	cast.add_child(kuroe_cameo)
	for identity in ["hana", "shion"]:
		var cameo := preload("res://scripts/opening/quiet_cameo.gd").new()
		cameo.street = self
		cameo.identity = identity
		cast.add_child(cameo)
		quiet_cameos.append(cameo)
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
		return Vector2(75,555) if location == "bridge" else Vector2(110,545)
	var clearance := 24.0*lane_scale(feet_y)
	for i in range(1,STREET_EDGES.size()):
		var a: Vector3 = STREET_EDGES[i-1]
		var b: Vector3 = STREET_EDGES[i]
		if feet_y <= b.x:
			var t := clampf((feet_y-a.x)/(b.x-a.x),0,1)
			return Vector2(lerpf(a.y,b.y,t)+clearance,lerpf(a.z,b.z,t)-clearance)
	return Vector2(395+clearance,680-clearance)

func constrain_position(at: Vector2) -> Vector2:
	if location == "interior":
		return Vector2(clampf(at.x,125,500),clampf(at.y,263,269))
	if location == "bridge":
		at.x = clampf(at.x,75,555)
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

func add_rail_patch(points: PackedVector2Array, target: Node2D = null) -> void:
	var patch := Polygon2D.new()
	patch.polygon = points
	var texcoords := PackedVector2Array()
	for point in points:
		texcoords.append(point*Vector2(backdrop.texture.get_width()/640.0,backdrop.texture.get_height()/360.0))
	patch.uv = texcoords
	patch.texture = backdrop.texture
	patch.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	(bridge_rail if target == null else target).add_child(patch)

func build_bridge_rail() -> void:
	bridge_rail = Node2D.new()
	bridge_rail.z_index = 20
	add_child(bridge_rail)
	# Exact source-image patches put the near rail in front of the actor.
	add_rail_patch(PackedVector2Array([Vector2(190,179),Vector2(265,174),Vector2(345,174),Vector2(435,184),Vector2(544,201),Vector2(544,212),Vector2(435,196),Vector2(345,186),Vector2(265,185),Vector2(190,191)]))
	for post in [Rect2(248,151,10,36),Rect2(361,157,9,31),Rect2(486,166,11,37),Rect2(535,181,10,32)]:
		add_rail_patch(PackedVector2Array([post.position,post.position+Vector2(post.size.x,0),post.end,post.position+Vector2(0,post.size.y)]))

func build_house_rail() -> void:
	house_rail = Node2D.new()
	house_rail.z_index = 20
	add_child(house_rail)
	add_rail_patch(PackedVector2Array([Vector2(0,244),Vector2(100,262),Vector2(190,277),Vector2(280,291),Vector2(300,294),Vector2(335,310),Vector2(383,316),Vector2(418,300),Vector2(433,279),Vector2(540,288),Vector2(640,288),Vector2(640,360),Vector2(0,360)]),house_rail)
	for post in [Rect2(137,260,21,67),Rect2(232,270,22,63),Rect2(314,272,20,45),Rect2(426,267,23,65),Rect2(516,265,22,68)]:
		add_rail_patch(PackedVector2Array([post.position,post.position+Vector2(post.size.x,0),post.end,post.position+Vector2(0,post.size.y)]),house_rail)

func show_location(next_location: String) -> void:
	location = next_location
	for cameo in quiet_cameos:
		cameo.refresh_visibility()
	if is_instance_valid(featured_actor):
		featured_actor.set_active(location == "house")
	for resident in residents:
		resident.hide()
		resident.set_physics_process(false)
	foreground.hide()
	if is_instance_valid(bridge_rail):
		bridge_rail.hide()
	if is_instance_valid(house_rail):
		house_rail.hide()
	if location == "interior":
		backdrop.texture = preload("res://assets/opening/reference/SHARED_HOME_CLINIC_INTERIOR_PIXEL_V1.png")
		backdrop.scale = Vector2(640.0/backdrop.texture.get_width(),360.0/backdrop.texture.get_height())
		camera.position = Vector2(320,180)
		camera_x = 320
		player.position = Vector2(190,266)
		player.scale = Vector2.ONE*1.15
		player.facing = 3
		player.velocity = Vector2.ZERO
		if is_instance_valid(featured_actor):
			# Stand beside the front walking lane, leaving room to pass her collider.
			featured_actor.position = Vector2(290,244)
			featured_actor.scale = Vector2.ONE*0.72
			featured_actor.set_active(true)
		return
	var file := "BRIDGE_PIXEL_V1.png" if location == "bridge" else "MIYAKO_HOUSE_EXTERIOR_PIXEL_V1.png"
	backdrop.texture = load("res://assets/opening/reference/"+file)
	backdrop.scale = Vector2(640.0/backdrop.texture.get_width(),360.0/backdrop.texture.get_height())
	if location == "bridge":
		if not is_instance_valid(bridge_rail):
			build_bridge_rail()
		bridge_rail.show()
	else:
		if not is_instance_valid(house_rail):
			build_house_rail()
		house_rail.show()
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
