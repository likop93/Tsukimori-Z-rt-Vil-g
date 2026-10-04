extends Node
# Owns the chapter transition; all progression requires acknowledgement.
var runner: Node
var done := false
var phase := "room"
var vn: CanvasLayer
var patient_index := 0
var observe_down := false

func begin() -> void:
	runner.dialogue.hide()
	runner.weather.hide()
	runner.heading.show()
	runner.hint.show()
	runner.street.show_location("akira_room")
	GameState.set_flag("visited_akira_room")
	resume("room")

func resume(next_phase: String) -> void:
	phase = next_phase
	observe_down = Input.is_action_pressed("observe")
	runner.street.enable_control()
	runner.hint.show()
	runner.heading.text = "Akira szobája · első este" if phase == "room" else "Rendelő · első nap"

func advance(_delta: float) -> void:
	var down := Input.is_action_pressed("observe")
	var interact := down and not observe_down
	observe_down = down
	if phase not in ["room","clinic"]:
		return
	var x: float = runner.street.player.position.x
	if phase == "room":
		runner.hint.text = "E · fénykép az íróasztalon" if x > 250 and x < 380 else ("E · lefekvés" if x > 460 else "Az íróasztalnál egy fénykép vár.    WASD · séta / Shift · futás")
		if interact:
			if x > 250 and x < 380:
				play({"portrait":false,"lines":[{"speaker":"","text":"Régi fénykép: Akira és Katsuro."}]},"photo")
			elif x > 460:
				play(read_data("res://data/opening/first_night.json"),"night")
	else:
		runner.hint.text = "E · következő konzultáció" if x > 240 and x < 390 and patient_index < 2 else ("A mai két konzultáció lezárult.    Tab / Esc · menü" if patient_index == 2 else "Sétálj a konzultáció helyéhez.    WASD · séta")
		if interact and x > 240 and x < 390 and patient_index < 2:
			play(read_data("res://data/home_day1/patient_%d.json" % (patient_index+1)),"patient")

func read_data(path: String) -> Dictionary:
	return JSON.parse_string(FileAccess.get_file_as_string(path))

func play(data: Dictionary, next_phase: String) -> void:
	phase = next_phase
	runner.street.player.input_enabled = false
	runner.street.player.velocity = Vector2.ZERO
	runner.street.player.scripted_axis = Vector2.ZERO
	runner.hint.hide()
	if is_instance_valid(vn):
		vn.queue_free()
	vn = preload("res://scripts/ui/vn_dialogue.gd").new()
	add_child(vn)
	vn.finished.connect(finish_dialogue)
	vn.choice_selected.connect(on_choice)
	vn.begin(data)

func on_choice(id: String) -> void:
	if phase == "morning" and id in ["stay","withdraw"] and GameState.miyako_morning_choice.is_empty():
		GameState.miyako_morning_choice = id
		if id == "stay":
			GameState.aff_miyako += 1
			GameState.akira_gyogyulas += 1
		else:
			GameState.set_flag("flag_miyako_tavolsag")
	elif phase == "clinic_morning" and id in ["empathy","clinical"] and GameState.clinic_first_choice.is_empty():
		GameState.clinic_first_choice = id
		if id == "empathy":
			GameState.aff_hana += 1
			GameState.aff_shion += 1
			GameState.akira_gyogyulas += 1
		else:
			GameState.set_flag("flag_klinikai_tavolsag")

func finish_dialogue() -> void:
	match phase:
		"photo":
			GameState.set_flag("katsuro_first_clue_seen")
			resume("room")
		"night":
			GameState.set_flag("first_night_seen")
			runner.street.show_location("interior")
			runner.street.backdrop.texture = load("res://assets/home_day1/morning_REVIEW.png")
			runner.street.backdrop.scale = Vector2(640.0/runner.street.backdrop.texture.get_width(),360.0/runner.street.backdrop.texture.get_height())
			runner.heading.text = "Második reggel"
			play(read_data("res://data/home_day1/morning.json"),"morning")
		"morning":
			GameState.set_flag("miyako_morning_seen")
			play(read_data("res://data/home_day1/clinic_morning.json"),"clinic_morning")
		"clinic_morning":
			GameState.set_flag("first_clinic_day_started")
			runner.street.show_location("clinic")
			resume("clinic")
		"patient":
			patient_index += 1
			GameState.set_flag("first_day_consultation_%d_seen" % patient_index)
			if patient_index == 2:
				GameState.set_flag("first_clinic_day_seen")
			resume("clinic")
