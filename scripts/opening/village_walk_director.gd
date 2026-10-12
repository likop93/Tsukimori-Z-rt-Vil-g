extends "res://scripts/opening/village_tour_director.gd"
# Reuse the approved orientation dialogue/state on surveyed playable plates.
const PLACES := {
	"school":{"area":"street","at":Vector2(495,182)},
	"shop":{"area":"street","at":Vector2(602,228)},
	"inn":{"area":"street","at":Vector2(488,279)},
	"market":{"area":"street","at":Vector2(615,329)},
	"workshop":{"area":"bridge","at":Vector2(160,190)},
	"stream":{"area":"bridge","at":Vector2(265,181)},
	"music":{"area":"bridge","at":Vector2(410,189)},
	"shrine":{"area":"bridge","at":Vector2(530,202)}
}
var area := "street"
var mode := "walk"
var armed := false
var markers: Node2D
var saved_positions := {"street":Vector2(550,310),"bridge":Vector2(85,191)}
var saved_facing := 3
var nearest := ""

func set_background(kind: String) -> void:
	super.set_background(kind)
	var bridge := kind == "bridge"
	runner.street.backdrop.texture = load("res://assets/village_day1/bridge_afternoon_v1_REVIEW.png" if bridge else "res://assets/village_day1/street_afternoon_v1_REVIEW.png")
	var texture: Texture2D = runner.street.backdrop.texture
	runner.street.backdrop.scale = Vector2(640.0/texture.get_width(),360.0/texture.get_height()) if bridge else Vector2(1085.0/texture.get_width(),362.5/texture.get_height())
	runner.street.camera_x = 320 if bridge else 542
	runner.street.camera.position = Vector2(runner.street.camera_x,180)
	# Flat VN composition must not inherit playable rails or ambient actors.
	runner.street.location = "tour_dialogue"
	runner.street.foreground.hide()
	for rail in [runner.street.bridge_rail, runner.street.house_rail]:
		if is_instance_valid(rail):
			rail.hide()
	for resident in runner.street.residents:
		resident.hide()
		resident.set_physics_process(false)
	for cameo in runner.street.quiet_cameos:
		cameo.refresh_visibility()
	runner.street.kuroe_cameo.hide()

func show_menu() -> void:
	# Parent calls this after each conversation; resume exactly at its entrance.
	current_stop = ""
	if is_instance_valid(vn):
		vn.queue_free()
		vn = null
	show_walk()

func show_walk() -> void:
	mode = "walk"
	armed = false
	runner.street.show_location(area,true)
	runner.street.enabled = true
	# The orientation only teases these places; their original opening cameos
	# must not replay or reveal their occupants in the new afternoon sequence.
	runner.street.kuroe_cameo.set_physics_process(false)
	runner.street.kuroe_cameo.hide()
	for cameo in runner.street.quiet_cameos:
		cameo.set_physics_process(false)
		cameo.hide()
	runner.street.camera_locked = true
	runner.street.backdrop.modulate = Color.WHITE
	var player: CharacterBody2D = runner.street.player
	player.position = runner.street.constrain_position(saved_positions[area])
	player.facing = saved_facing
	player.velocity = Vector2.ZERO
	player.scripted_axis = Vector2.ZERO
	player.show()
	player.input_enabled = true
	runner.heading.show()
	runner.heading.add_theme_color_override("font_outline_color",Color("#16151e"))
	runner.heading.add_theme_constant_override("outline_size",3)
	runner.hint.add_theme_color_override("font_outline_color",Color("#16151e"))
	runner.hint.add_theme_constant_override("outline_size",3)
	runner.heading.text = ("Falusi utca" if area == "street" else "Patakpart és híd")+" · %d/8 hely" % visited.size()
	runner.hint.show()
	build_markers()
	update_hint()

func build_markers() -> void:
	if is_instance_valid(markers):
		markers.queue_free()
	markers = Node2D.new()
	markers.z_index = 30
	runner.street.add_child(markers)
	for id in PLACES:
		if PLACES[id].area != area:
			continue
		var marker := Label.new()
		marker.text = ("✓ " if visited.has(id) else "◇ ")+str(tour_data.stops[id].label)
		marker.position = PLACES[id].at+Vector2(-45,5)
		marker.size = Vector2(100,20)
		marker.add_theme_font_size_override("font_size",11)
		marker.add_theme_color_override("font_color",Color("#b1b9ad") if visited.has(id) else Color("#f1d49b"))
		marker.add_theme_color_override("font_outline_color",Color("#11121c"))
		marker.add_theme_constant_override("outline_size",4)
		markers.add_child(marker)

func interaction() -> String:
	var at: Vector2 = runner.street.player.position
	var exit_at := Vector2(550,337) if area == "street" else Vector2(78,191)
	if at.distance_to(exit_at) < 19:
		return "change_area"
	if area == "bridge" and at.distance_to(Vector2(551,205)) < 14 and visited.size() == STOP_ORDER.size():
		return "home"
	var best := 24.0
	var found := ""
	for id in PLACES:
		if PLACES[id].area != area:
			continue
		var distance: float = at.distance_to(PLACES[id].at)
		if distance < best:
			best = distance
			found = id
	return found

func update_hint() -> void:
	nearest = interaction()
	if nearest == "change_area":
		runner.hint.text = "E · Átmegyek a patakpartra" if area == "street" else "E · Vissza a falusi utcára"
	elif nearest == "home":
		runner.hint.text = "E · Hazatérek Miyakóhoz"
	elif not nearest.is_empty():
		runner.hint.text = ("Már felkerested · " if visited.has(nearest) else "E · ")+str(tour_data.stops[nearest].label)
	else:
		runner.hint.text = ("WASD / nyilak · séta  |  Shift · futás  |  Lent: patakpart" if area == "street" else "WASD / nyilak · séta  |  Balra: utca  |  Jobbra: hazatérés")

func advance(_delta: float) -> void:
	if get_tree().paused or mode != "walk":
		return
	update_hint()
	var pressed := Input.is_action_pressed("observe")
	if not pressed:
		armed = true
		return
	if not armed:
		return
	armed = false
	if nearest == "change_area":
		saved_positions[area] = runner.street.player.position
		saved_facing = runner.street.player.facing
		area = "bridge" if area == "street" else "street"
		show_walk()
	elif nearest == "home":
		finish_tour()
	elif not nearest.is_empty() and not visited.has(nearest):
		open_stop(nearest)

func open_stop(id: String) -> void:
	if mode != "walk" or get_tree().paused or not PLACES.has(id) or visited.has(id) or interaction() != id:
		return
	saved_positions[area] = runner.street.player.position
	saved_facing = runner.street.player.facing
	mode = "dialogue"
	runner.street.player.input_enabled = false
	runner.street.player.velocity = Vector2.ZERO
	if is_instance_valid(markers):
		markers.hide()
	super.open_stop(id)

func finish_tour() -> void:
	if mode != "walk" or get_tree().paused or visited.size() != STOP_ORDER.size():
		return
	mode = "complete"
	runner.street.player.input_enabled = false
	runner.street.player.velocity = Vector2.ZERO
	super.finish_tour()

func _exit_tree() -> void:
	if is_instance_valid(markers):
		markers.queue_free()
