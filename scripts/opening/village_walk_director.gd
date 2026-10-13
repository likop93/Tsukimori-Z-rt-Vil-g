extends "res://scripts/opening/village_tour_director.gd"
const PLACES := {
	"school":{"area":"school","at":Vector2(366,298)},
	"shop":{"area":"shop","at":Vector2(421,298)},
	"inn":{"area":"inn","at":Vector2(370,303)},
	"market":{"area":"market","at":Vector2(407,291)},
	"workshop":{"area":"craft_lane","at":Vector2(211,294)},
	"music":{"area":"craft_lane","at":Vector2(485,294)},
	"stream":{"area":"stream","at":Vector2(172,298)},
	"shrine":{"area":"shrine","at":Vector2(333,299)}
}
var layout: Dictionary = {}
var area := "square"
var mode := "walk"
var armed := false
var markers: Node2D
var cast: Node2D
var occlusion: Node2D
var saved_positions: Dictionary = {}
var saved_facings: Dictionary = {}
var saved_facing := 3
var nearest := ""
var map_panel: Control
var interiors: Dictionary = {}

func begin() -> void:
	layout = JSON.parse_string(FileAccess.get_file_as_string("res://data/home_day1/village_layout.json")).locations
	interiors = JSON.parse_string(FileAccess.get_file_as_string("res://data/home_day1/village_interiors.json"))
	for id in layout:
		saved_positions[id] = point(layout[id].spawn)
		saved_facings[id] = 3
	super.begin()

func point(value: Array) -> Vector2:
	return Vector2(value[0],value[1])

func set_background(_kind: String) -> void:
	chapter.hide_actors()
	if is_instance_valid(cast):
		cast.hide()
	if is_instance_valid(occlusion):
		occlusion.hide()
	runner.street.foreground.hide()
	for rail in [runner.street.bridge_rail,runner.street.house_rail]:
		if is_instance_valid(rail):
			rail.hide()
	for resident in runner.street.residents:
		resident.hide()
		resident.set_physics_process(false)

func show_menu() -> void:
	current_stop = ""
	if is_instance_valid(vn):
		vn.queue_free()
		vn = null
	show_walk()

func clear_staging() -> void:
	for node in [markers,cast,occlusion]:
		if is_instance_valid(node):
			node.hide()
			node.queue_free()

func show_walk() -> void:
	mode = "walk"
	armed = false
	clear_staging()
	var spec: Dictionary = layout[area]
	if area == "bridge":
		runner.street.show_location("bridge",true)
	else:
		var b: Array = spec.bounds
		runner.street.show_tour_location(str(spec.background),Rect2(b[0],b[1],b[2],b[3]),float(spec.scale))
	runner.street.enabled = true
	runner.street.camera_locked = true
	runner.street.kuroe_cameo.set_physics_process(false)
	runner.street.kuroe_cameo.hide()
	for cameo in runner.street.quiet_cameos:
		cameo.set_physics_process(false)
		cameo.hide()
	var player: CharacterBody2D = runner.street.player
	player.position = runner.street.constrain_position(saved_positions[area])
	player.facing = int(saved_facings[area])
	player.velocity = Vector2.ZERO
	player.scripted_axis = Vector2.ZERO
	player.show()
	player.input_enabled = true
	runner.heading.show()
	for label in [runner.heading,runner.hint]:
		label.add_theme_color_override("font_outline_color",Color("#16151e"))
		label.add_theme_constant_override("outline_size",3)
	runner.heading.text = str(spec.title)+" · %d/8 hely" % visited.size()
	runner.hint.show()
	build_cast()
	build_markers()
	build_occlusion()
	update_hint()

func remember_position() -> void:
	saved_positions[area] = runner.street.player.position
	saved_facings[area] = runner.street.player.facing
	saved_facing = runner.street.player.facing

func enter_location(target: String) -> void:
	if mode != "walk" or get_tree().paused or not layout.has(target):
		return
	var connected := false
	for exit_spec in layout[area].exits:
		if exit_spec.target == target:
			connected = true
	if not connected:
		return
	remember_position()
	area = target
	show_walk()

func build_cast() -> void:
	cast = Node2D.new()
	# Share Akira's y-sort parent; feet determine overlap.
	runner.street.player.get_parent().add_child(cast)
	cast.y_sort_enabled = true
	for actor_spec in layout[area].actors:
		if visited.has(str(actor_spec.get("hide_after",""))):
			continue
		if not ResourceLoader.exists(str(actor_spec.path)):
			continue
		var actor := preload("res://scripts/opening/tour_character.gd").new()
		actor.spec = actor_spec
		actor.name = str(actor_spec.id)
		actor.player = runner.street.player
		actor.position = point(actor_spec.at)
		cast.add_child(actor)
	for i in layout[area].ambient.size():
		var source: Dictionary = runner.street.data.npc[i % runner.street.data.npc.size()]
		var actor := preload("res://scripts/opening/resident.gd").new()
		actor.atlas = load(str(source.atlas))
		actor.row = i+1
		actor.look_left_frame = source.look_left_frame
		actor.look_right_frame = source.look_right_frame
		actor.mirror_left_look = source.mirror_left_look
		actor.behavior = "slow_walk" if i % 2 == 0 else "idle"
		actor.roam_range = 9 if i % 2 == 0 else 0
		actor.walk_speed = 5
		actor.player = runner.street.player
		actor.position = point(layout[area].ambient[i])
		actor.scale = Vector2.ONE*1.25
		cast.add_child(actor)

func build_occlusion() -> void:
	occlusion = Node2D.new()
	occlusion.z_index = 20
	runner.street.add_child(occlusion)
	if area in ["square","market","craft_lane","stream","shrine"]:
		# Only the surveyed near-corner flowers overlap the walking strip.
		runner.street.add_rail_patch(PackedVector2Array([Vector2(0,311),Vector2(48,326),Vector2(104,360),Vector2(0,360)]),occlusion)
		runner.street.add_rail_patch(PackedVector2Array([Vector2(640,311),Vector2(592,326),Vector2(536,360),Vector2(640,360)]),occlusion)

func add_marker(text: String, at: Vector2, done := false) -> void:
	var marker := Label.new()
	marker.text = text
	marker.position = Vector2(clampf(at.x-49,4,538),at.y+7)
	marker.size = Vector2(98,20)
	marker.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	marker.add_theme_font_size_override("font_size",10)
	marker.add_theme_color_override("font_color",Color("#bdc7ba") if done else Color("#f1d49b"))
	marker.add_theme_color_override("font_outline_color",Color("#11121c"))
	marker.add_theme_constant_override("outline_size",3)
	markers.add_child(marker)

func build_markers() -> void:
	markers = Node2D.new()
	markers.z_index = 30
	runner.street.add_child(markers)
	for exit_spec in layout[area].exits:
		add_marker("› "+str(exit_spec.label),point(exit_spec.at))
	for id in layout[area].stops:
		var prefix := "› " if visited.has(id) and interiors.has(id) else "✓ " if visited.has(id) else "◇ "
		add_marker(prefix+str(tour_data.stops[id].label),point(layout[area].stops[id]),visited.has(id))

func interaction() -> String:
	var at: Vector2 = runner.street.player.position
	var best := 28.0
	var found := ""
	for exit_spec in layout[area].exits:
		var distance: float = at.distance_to(point(exit_spec.at))
		if distance < best:
			best = distance
			found = "exit:"+str(exit_spec.target)
	for id in layout[area].stops:
		var distance: float = at.distance_to(point(layout[area].stops[id]))
		if distance < best:
			best = distance
			found = id
	if visited.has(found) and interiors.has(found):
		return "inside:"+found
	return found

func update_hint() -> void:
	nearest = interaction()
	if nearest == "exit:home":
		runner.hint.text = "E · Hazatérek Miyakóhoz" if visited.size() == STOP_ORDER.size() else "Még %d hely vár felfedezésre · M: térkép" % (STOP_ORDER.size()-visited.size())
	elif nearest.begins_with("exit:"):
		runner.hint.text = "E · "+str(layout[nearest.trim_prefix("exit:")].title)+"   |   M · térkép"
	elif nearest.begins_with("inside:"):
		runner.hint.text = "E · Belépek: "+str(tour_data.stops[nearest.trim_prefix("inside:")].label)
	elif not nearest.is_empty():
		runner.hint.text = ("Már felkerested · " if visited.has(nearest) else "E · ")+str(tour_data.stops[nearest].label)
	else:
		runner.hint.text = "WASD / nyilak · séta   Shift · futás   E · megszólítás / átjáró   M · térkép"

func advance(_delta: float) -> void:
	if get_tree().paused or mode != "walk":
		return
	update_hint()
	if not Input.is_action_pressed("observe"):
		armed = true
		return
	if not armed:
		return
	armed = false
	if nearest == "exit:home":
		finish_tour()
	elif nearest.begins_with("exit:"):
		enter_location(nearest.trim_prefix("exit:"))
	elif nearest.begins_with("inside:"):
		open_interior(nearest.trim_prefix("inside:"))
	elif not nearest.is_empty() and not visited.has(nearest):
		open_stop(nearest)

func open_stop(id: String) -> void:
	if mode != "walk" or get_tree().paused or not PLACES.has(id) or visited.has(id) or interaction() != id:
		return
	remember_position()
	mode = "dialogue"
	runner.street.player.input_enabled = false
	runner.street.player.velocity = Vector2.ZERO
	markers.hide()
	super.open_stop(id)

func open_interior(id: String) -> void:
	if mode != "walk" or get_tree().paused or interaction() != "inside:"+id:
		return
	remember_position()
	mode = "interior"
	markers.hide()
	set_background("")
	var spec: Dictionary = interiors[id]
	var texture: Texture2D = load(str(spec.background))
	runner.street.backdrop.texture = texture
	runner.street.backdrop.scale = Vector2(640.0/texture.get_width(),360.0/texture.get_height())
	runner.heading.text = str(spec.title)
	runner.hint.hide()
	vn = preload("res://scripts/ui/vn_dialogue.gd").new()
	add_child(vn)
	vn.finished.connect(show_menu)
	vn.begin({"id":"village_interior_"+id,"portrait":false,"lines":spec.lines})

func _unhandled_key_input(event: InputEvent) -> void:
	if get_tree().paused or not event is InputEventKey or not event.pressed or event.echo:
		return
	if event.keycode == KEY_M and mode in ["walk","map"]:
		toggle_map()
		get_viewport().set_input_as_handled()

func toggle_map() -> void:
	if mode == "map":
		map_panel.queue_free()
		mode = "walk"
		runner.street.player.input_enabled = true
		cast.process_mode = Node.PROCESS_MODE_INHERIT
		armed = false
		return
	if mode != "walk":
		return
	mode = "map"
	runner.street.player.input_enabled = false
	runner.street.player.velocity = Vector2.ZERO
	cast.process_mode = Node.PROCESS_MODE_DISABLED
	map_panel = preload("res://scripts/ui/village_map.gd").new()
	map_panel.tour = self
	chapter.presentation.add_child(map_panel)

func finish_tour() -> void:
	if mode != "walk" or get_tree().paused or visited.size() != STOP_ORDER.size():
		return
	mode = "complete"
	clear_staging()
	runner.street.tour_bounds = Rect2()
	runner.street.player.input_enabled = false
	runner.street.player.velocity = Vector2.ZERO
	super.finish_tour()

func _exit_tree() -> void:
	clear_staging()
	if is_instance_valid(map_panel):
		map_panel.queue_free()
