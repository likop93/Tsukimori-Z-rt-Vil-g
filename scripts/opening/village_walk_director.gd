extends "res://scripts/opening/village_tour_director.gd"
# Owner revision: destination-based exploration. No manually controlled avatar.
const STOP_AREAS := {"school":"school","shop":"shop","inn":"inn","market":"market","workshop":"craft_lane","music":"craft_lane","stream":"stream","shrine":"shrine"}
var layout: Dictionary = {}
var interiors: Dictionary = {}
var area := "square"
var mode := "place"
var cast: Node2D
var map_panel: Control
var action_buttons: Array[Button] = []
var actions_armed := false
var travel_fade: ColorRect

func begin() -> void:
	layout = JSON.parse_string(FileAccess.get_file_as_string("res://data/home_day1/village_layout.json")).locations
	interiors = JSON.parse_string(FileAccess.get_file_as_string("res://data/home_day1/village_interiors.json"))
	super.begin()
	toggle_map()

func point(value: Array) -> Vector2:
	return Vector2(value[0],value[1])

func lock_player() -> void:
	chapter.hide_actors()
	runner.street.player.input_enabled = false
	runner.street.player.velocity = Vector2.ZERO
	runner.street.player.scripted_axis = Vector2.ZERO
	runner.street.player.hide()

func clear_ui() -> void:
	for item in [menu,map_panel]:
		if is_instance_valid(item):
			item.hide()
			item.queue_free()
	menu = null
	map_panel = null
	action_buttons.clear()

func clear_cast() -> void:
	if is_instance_valid(cast):
		cast.hide()
		cast.queue_free()
	cast = null

func set_background(_kind: String) -> void:
	lock_player()
	if is_instance_valid(cast):
		cast.hide()
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
	show_place()

func show_place() -> void:
	clear_ui()
	clear_cast()
	mode = "home" if area == "home" else "place"
	if area == "home":
		# Reuse the approved shared-home interior, with no walking overlay.
		runner.street.show_location("interior")
		var daylight := load("res://assets/home_day1/morning_REVIEW.png") as Texture2D
		runner.street.backdrop.texture = daylight
		runner.street.backdrop.scale = Vector2(640.0/daylight.get_width(),360.0/daylight.get_height())
	else:
		runner.street.show_tour_location(str(layout[area].background),Rect2(),1.0)
		build_cast()
	runner.street.enabled = false
	runner.street.tour_bounds = Rect2()
	lock_player()
	for cameo in runner.street.quiet_cameos:
		cameo.hide()
		cameo.set_physics_process(false)
	runner.street.kuroe_cameo.hide()
	runner.street.kuroe_cameo.set_physics_process(false)
	runner.heading.text = "Otthon · Miyako háza" if area == "home" else str(layout[area].title)
	runner.heading.show()
	runner.hint.hide()
	build_actions()

func make_button(parent: Node, id: String, text: String, at: Vector2, extent: Vector2, callback: Callable) -> Button:
	var button := Button.new()
	button.name = id
	button.text = text
	button.position = at
	button.size = extent
	button.add_theme_font_size_override("font_size",13)
	for state in ["normal","hover","focus","pressed"]:
		var box := StyleBoxFlat.new()
		box.bg_color = Color("#171c29") if state == "normal" else Color("#48394a")
		box.border_color = Color("#a28a6b") if state == "normal" else Color("#efd19a")
		box.set_border_width_all(1)
		box.set_corner_radius_all(4)
		button.add_theme_stylebox_override(state,box)
	button.disabled = true
	button.pressed.connect(callback)
	parent.add_child(button)
	action_buttons.append(button)
	return button

func build_actions() -> void:
	menu = Control.new()
	chapter.presentation.add_child(menu)
	var panel := ColorRect.new()
	panel.position = Vector2(0,254)
	panel.size = Vector2(640,106)
	panel.color = Color(0.035,0.035,0.06,0.95)
	menu.add_child(panel)
	actions_armed = false
	if area == "home":
		make_button(menu,"evening","Lezárom a délutánt · esti beszélgetés",Vector2(24,265),Vector2(592,32),finish_tour)
	else:
		var stops: Dictionary = layout[area].stops
		var i := 0
		for id in stops:
			var label := str(tour_data.stops[id].label)
			if visited.has(id):
				label = "Belépek · "+label if interiors.has(id) else "✓ "+label+" · már felkerested"
			else:
				label = "Körülnézek · "+label
			var button := make_button(menu,"stop_"+id,label,Vector2(24+i*300,265),Vector2(292,32),activate_stop.bind(id))
			button.set_meta("unavailable",visited.has(id) and not interiors.has(id))
			i += 1
		if stops.is_empty():
			var caption := Label.new()
			caption.text = "Válassz úti célt a térképen." if area == "square" else "A híd túloldalán Miyako otthona vár."
			caption.position = Vector2(24,270)
			caption.add_theme_font_size_override("font_size",14)
			menu.add_child(caption)
	make_button(menu,"map","Térkép · M",Vector2(24,311),Vector2(184,32),toggle_map)
	make_button(menu,"square","Főtér",Vector2(228,311),Vector2(184,32),navigate.bind("square"))
	make_button(menu,"home","Vissza a faluba" if area == "home" else "Hazamegyek",Vector2(432,311),Vector2(184,32),toggle_map if area == "home" else navigate.bind("home"))

func _process(_delta: float) -> void:
	if get_tree().paused or actions_armed or mode not in ["place","home","map"]:
		return
	if Input.is_action_pressed("observe") or Input.is_action_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	actions_armed = true
	for button in action_buttons:
		if is_instance_valid(button):
			button.disabled = bool(button.get_meta("unavailable",false))
	if not action_buttons.is_empty():
		for button in action_buttons:
			if not button.disabled:
				button.grab_focus()
				break

func navigate(target: String) -> void:
	if get_tree().paused or mode not in ["place","home","map"] or (target != "home" and not layout.has(target)):
		return
	mode = "travel"
	clear_ui()
	lock_player()
	travel_fade = ColorRect.new()
	travel_fade.size = Vector2(640,360)
	travel_fade.color = Color(0.015,0.018,0.03,0)
	travel_fade.mouse_filter = Control.MOUSE_FILTER_STOP
	chapter.presentation.add_child(travel_fade)
	var fade := travel_fade
	var tween := create_tween()
	tween.tween_property(fade,"color:a",1.0,0.18)
	await tween.finished
	area = target
	show_place()
	# show_place creates controls, but they must not accept input mid-transition.
	mode = "travel"
	chapter.presentation.move_child(fade,-1)
	tween = create_tween()
	tween.tween_property(fade,"color:a",0.0,0.18)
	await tween.finished
	fade.queue_free()
	travel_fade = null
	mode = "home" if area == "home" else "place"

func activate_stop(id: String) -> void:
	if visited.has(id) and interiors.has(id):
		open_interior(id)
	else:
		open_stop(id)

func open_stop(id: String) -> void:
	if mode != "place" or get_tree().paused or not layout[area].stops.has(id) or visited.has(id):
		return
	mode = "dialogue"
	clear_ui()
	super.open_stop(id)

func open_interior(id: String) -> void:
	if mode != "place" or get_tree().paused or not layout[area].stops.has(id) or not visited.has(id) or not interiors.has(id):
		return
	mode = "interior"
	clear_ui()
	set_background("")
	var spec: Dictionary = interiors[id]
	var texture: Texture2D = load(str(spec.background))
	runner.street.backdrop.texture = texture
	runner.street.backdrop.scale = Vector2(640.0/texture.get_width(),360.0/texture.get_height())
	runner.heading.text = str(spec.title)
	vn = preload("res://scripts/ui/vn_dialogue.gd").new()
	add_child(vn)
	vn.finished.connect(show_menu)
	vn.begin({"id":"village_interior_"+id,"portrait":false,"lines":spec.lines})

func advance(_delta: float) -> void:
	pass # Exploration is driven exclusively by destination/action buttons.

func _unhandled_key_input(event: InputEvent) -> void:
	if not get_tree().paused and event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_M and mode in ["place","home","map"]:
		toggle_map()
		get_viewport().set_input_as_handled()

func toggle_map() -> void:
	if get_tree().paused:
		return
	if mode == "map":
		clear_ui()
		mode = "home" if area == "home" else "place"
		build_actions()
		return
	if mode not in ["place","home"]:
		return
	clear_ui()
	mode = "map"
	actions_armed = false
	map_panel = preload("res://scripts/ui/village_map.gd").new()
	map_panel.tour = self
	chapter.presentation.add_child(map_panel)

func finish_tour() -> void:
	if mode != "home" or get_tree().paused:
		return
	mode = "complete"
	GameState.set_flag("village_tour_returned_home")
	if visited.size() == STOP_ORDER.size():
		GameState.set_flag("village_tour_complete")
	clear_ui()
	clear_cast()
	lock_player()
	completed.emit()
	queue_free()

func build_cast() -> void:
	cast = Node2D.new()
	runner.street.player.get_parent().add_child(cast)
	cast.y_sort_enabled = true
	for actor_spec in layout[area].actors:
		if visited.has(str(actor_spec.get("hide_after",""))) or not ResourceLoader.exists(str(actor_spec.path)):
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
		actor.behavior = "idle"
		actor.roam_range = 0
		actor.player = runner.street.player
		actor.position = point(layout[area].ambient[i])
		actor.scale = Vector2.ONE*1.25
		cast.add_child(actor)

func _exit_tree() -> void:
	clear_ui()
	clear_cast()
	if is_instance_valid(travel_fade):
		travel_fade.queue_free()
