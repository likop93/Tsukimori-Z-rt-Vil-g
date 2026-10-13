extends Node
# First village orientation: after the first clinic day, before the existing
# evening Miyako scene. Separate production backgrounds can replace the REVIEW
# stand-ins without changing story state.

signal completed

var runner: Node
var chapter: Node
var vn: CanvasLayer
var menu: Control
var current_stop := ""
var visited: Dictionary = {}
var tour_data: Dictionary = {}

const STOP_ORDER := ["school","shop","inn","workshop","market","stream","music","shrine"]

func begin() -> void:
	GameState.set_flag("village_tour_started")
	tour_data = JSON.parse_string(FileAccess.get_file_as_string("res://data/home_day1/village_tour.json"))
	for id in STOP_ORDER:
		var spec: Dictionary = tour_data.stops[id]
		if GameState.has_flag(str(spec.flag)):
			visited[id] = true
	set_background("village")
	show_menu()

func set_background(kind: String) -> void:
	chapter.hide_actors()
	var path := "res://assets/opening/reference/BRIDGE_PIXEL_V1.png" if kind == "bridge" else "res://assets/opening/reference/VILLAGE_STREET_PIXEL_V1.png"
	runner.street.backdrop.texture = load(path)
	runner.street.backdrop.scale = Vector2(640.0/runner.street.backdrop.texture.get_width(),360.0/runner.street.backdrop.texture.get_height())
	runner.street.backdrop.modulate = Color.WHITE
	runner.street.camera.position = Vector2(320,180)
	runner.street.camera_x = 320
	runner.street.player.hide()

func show_menu() -> void:
	current_stop = ""
	if is_instance_valid(vn):
		vn.queue_free()
	if is_instance_valid(menu):
		menu.queue_free()
	set_background("village")
	runner.heading.show()
	runner.heading.text = "Ismerd meg Tsukimorit · %d/%d" % [visited.size(),STOP_ORDER.size()]
	runner.hint.show()
	runner.hint.text = "Válassz helyszínt · a sorrend szabad"

	menu = Control.new()
	chapter.presentation.add_child(menu)

	var shade := ColorRect.new()
	shade.position = Vector2(18,54)
	shade.size = Vector2(604,250)
	shade.color = Color(0.02,0.025,0.04,0.82)
	menu.add_child(shade)

	var intro := Label.new()
	intro.text = "Első szabad délután · járd be a falu fontos helyeit"
	intro.position = Vector2(38,66)
	intro.size = Vector2(564,28)
	intro.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	intro.add_theme_font_size_override("font_size",16)
	menu.add_child(intro)

	var first_focus: Button = null
	for i in STOP_ORDER.size():
		var id: String = STOP_ORDER[i]
		var spec: Dictionary = tour_data.stops[id]
		var button := Button.new()
		var col := i % 2
		var row := floori(i / 2.0)
		button.position = Vector2(52 + col*274,105 + row*40)
		button.size = Vector2(250,32)
		button.text = ("✓ " if visited.has(id) else "") + str(spec.label)
		button.disabled = visited.has(id)
		button.pressed.connect(open_stop.bind(id))
		menu.add_child(button)
		if first_focus == null and not button.disabled:
			first_focus = button

	if visited.size() == STOP_ORDER.size():
		var home := Button.new()
		home.text = "Hazatérek Miyakóhoz"
		home.position = Vector2(200,270)
		home.size = Vector2(240,34)
		home.pressed.connect(finish_tour)
		menu.add_child(home)
		home.grab_focus()
	elif first_focus != null:
		first_focus.grab_focus()

func open_stop(id: String) -> void:
	if visited.has(id):
		return
	current_stop = id
	if is_instance_valid(menu):
		menu.hide()
	var spec: Dictionary = tour_data.stops[id]
	set_background(str(spec.background))
	runner.heading.text = str(spec.title)
	runner.hint.hide()

	var data: Dictionary = {
		"id": "village_tour_"+id,
		"portrait": bool(spec.get("portrait",false)),
		"lines": spec.lines
	}
	for key in ["portrait_speaker","portrait_path","portrait_side","portrait_facing","portrait_trim","portrait_frame_fraction","portrait_region","portrait_variants","akira_portrait_path","source"]:
		if spec.has(key):
			data[key] = spec[key]

	vn = preload("res://scripts/ui/vn_dialogue.gd").new()
	add_child(vn)
	vn.finished.connect(on_stop_finished)
	vn.begin(data)

func on_stop_finished() -> void:
	var id := current_stop
	if id.is_empty():
		return
	var spec: Dictionary = tour_data.stops[id]
	visited[id] = true
	GameState.set_flag(str(spec.flag))
	match id:
		"school":
			GameState.set_flag("met_reina")
			GameState.set_flag("reina_first_meeting_seen")
		"shop":
			GameState.set_flag("met_aoi")
		"inn":
			GameState.set_flag("met_sora")
		"workshop":
			GameState.set_flag("met_ritsu")
		"market":
			GameState.set_flag("hana_market_glimpse_seen")
		"stream":
			GameState.set_flag("shion_stream_place_discovered")
		"music":
			GameState.set_flag("kuroe_music_place_discovered")
		"shrine":
			GameState.set_flag("oto_shrine_glimpse_seen")
	show_menu()

func finish_tour() -> void:
	if visited.size() != STOP_ORDER.size():
		return
	GameState.set_flag("village_tour_complete")
	if is_instance_valid(menu):
		menu.queue_free()
	runner.hint.hide()
	completed.emit()
	queue_free()
