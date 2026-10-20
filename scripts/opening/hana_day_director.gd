extends Node
# Original first Hana appointment; spatial plates stay VN-only.
var runner: Node
var chapter: Node
var phase := "night_notebook"
var vn: CanvasLayer
var met_at_line := -1
var end_card: Control
var continue_button: Button
var continue_armed := false
var afternoon_walk: Node

func begin() -> void:
	GameState.set_story_time(1,"night")
	GameState.set_flag("hana_day_started")
	chapter.night_image.hide()
	runner.heading.show()
	set_location("clinic","Az éjszakai füzet")
	runner.street.backdrop.modulate = Color(0.42,0.48,0.64)
	play("night_notebook")

func set_location(location: String, title: String) -> void:
	runner.street.show_location(location)
	chapter.hide_actors()
	runner.heading.text = title
	runner.hint.hide()

func play(id: String) -> void:
	phase = id
	if is_instance_valid(vn):
		vn.queue_free()
	var data: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/home_day2/"+id+".json"))
	if id == "miyako_tea" and GameState.character_stage("miyako") > 0:
		var stage := GameState.character_stage("miyako")
		data.lines.insert(3,{"speaker":"","text":"Miyako mosolya azután is az arcán maradt, hogy Akira elfordult. Tekintete minden mozdulatát követte." if stage == 2 else "Miyako pillantása megállt a két szék közti távolságon. Csak azután nézett vissza Akirára."})
	met_at_line = int(data.get("met_at_line",-1))
	vn = preload("res://scripts/ui/vn_dialogue.gd").new()
	add_child(vn)
	vn.finished.connect(finish_dialogue)
	vn.choice_selected.connect(on_choice)
	vn.line_shown.connect(on_line)
	vn.begin(data)

func on_line(index: int) -> void:
	if phase == "miyako_seal":
		var event := str(vn.lines[index].get("event",""))
		if not event.is_empty():
			GameState.set_flag(event)
		if event == "akira_right_eye_green":
			vn.akira_portrait.texture = load("res://assets/opening/vn_portraits/akira_doctor_green_eye_v1_REVIEW.png")
	if phase.begins_with("shion_"):
		var event := str(vn.lines[index].get("event",""))
		if event in ["met_shion","shion_eye_recognition_seen","shion_tape_found","shion_shared_memory_seen"]:
			GameState.set_flag(event)
	if phase == "night_visitor":
		var event := str(vn.lines[index].get("event",""))
		var flags := {"dream_pool":"black_pool_dream_seen","wet_notebook":"wet_notebook_seen","visitor_seen":"night_visitor_glimpsed","visitor_named":"shion_name_heard","appointment":"shion_appointment_expected"}
		if flags.has(event):
			GameState.set_flag(flags[event])
	if phase == "miyako_afternoon":
		var event := str(vn.lines[index].get("event",""))
		if event == "notebook_awakening":
			GameState.set_flag("katsuro_notebook_awakening_seen")
			runner.street.backdrop.modulate = Color(0.68,0.72,0.85)
		elif event == "wrist_mark":
			GameState.set_flag("akira_wrist_mark_seen")
		elif event == "knock":
			chapter.night_cue.stream = runner.ambience.make_effect("wood")
			chapter.night_cue.volume_db = -27
			chapter.night_cue.play()
		elif event == "window_whisper":
			runner.ambience.rain.stop()
	if phase == "hana_arrival" and index >= met_at_line and met_at_line >= 0:
		GameState.set_flag("met_hana")

func on_choice(id: String) -> void:
	if phase == "miyako_tea":
		GameState.record_personal_choice(phase,id)
	if phase == "shion_arrival" and not GameState.has_flag("shion_melody_decided") and id in ["join_melody","wait_melody"]:
		GameState.set_flag("shion_melody_decided")
		if id == "join_melody":
			GameState.aff_shion += 2
			GameState.akira_elmerules += 1
			GameState.set_flag("flag_shion_dallam_azonnal")
		else:
			GameState.akira_gyogyulas += 1
			GameState.set_flag("flag_shion_dallam_var")
	elif phase == "shion_memory" and not GameState.has_flag("shion_tape_decided") and id in ["play_tape","ask_consent"]:
		GameState.set_flag("shion_tape_decided")
		if id == "play_tape":
			GameState.akira_elmerules += 2
			GameState.set_flag("flag_akira_kazetta_surget")
		else:
			GameState.aff_shion += 1
			GameState.akira_gyogyulas += 1
			GameState.set_flag("flag_akira_kazetta_beleegyezes")
	if phase == "hana_arrival" and GameState.hana_first_choice.is_empty() and id in ["ask_body","let_lead"]:
		GameState.hana_first_choice = id
		if id == "ask_body":
			GameState.aff_hana += 1
			GameState.akira_gyogyulas += 1
			GameState.set_flag("hana_sajat_test")
			GameState.set_flag("hana_terapias_hatar")
		else:
			GameState.set_flag("flag_hana_hagyja_vezetni")
			GameState.set_flag("hana_provokacio")
	elif phase == "hana_memory" and GameState.hana_memory_choice.is_empty() and id in ["recall","wait"]:
		GameState.hana_memory_choice = id
		if id == "recall":
			GameState.aff_hana += 2
			GameState.akira_elmerules += 1
		else:
			GameState.akira_gyogyulas += 1
			GameState.set_flag("flag_hana_emlek_tavolsag")

func finish_dialogue() -> void:
	match phase:
		"night_notebook":
			GameState.set_story_time(2,"morning")
			GameState.visit_location("home")
			GameState.set_flag("katsuro_returned_notebook_seen")
			set_location("interior","Második rendelési nap · reggel")
			runner.street.backdrop.texture = load("res://assets/home_day1/morning_REVIEW.png")
			runner.street.backdrop.scale = Vector2(640.0/runner.street.backdrop.texture.get_width(),360.0/runner.street.backdrop.texture.get_height())
			runner.street.backdrop.modulate = Color.WHITE
			runner.ambience.rain.volume_db = -37
			play("morning_hana")
		"morning_hana":
			GameState.set_story_time(2,"clinic")
			GameState.visit_location("clinic")
			GameState.set_flag("hana_appointment_prepared")
			set_location("clinic","Rendelő · Hana")
			runner.street.backdrop.modulate = Color.WHITE
			play("hana_arrival")
		"hana_arrival":
			GameState.set_flag("hana_first_boundary_seen")
			play("hana_memory")
		"hana_memory":
			GameState.set_flag("hana_memory_discussed")
			play("hana_close")
		"hana_close":
			GameState.set_flag("hana_first_session_seen")
			phase = "hana_complete"
			show_end()
		"miyako_afternoon":
			GameState.set_flag("miyako_hana_afternoon_seen")
			phase = "afternoon_complete"
			show_end()
		"night_visitor":
			GameState.set_flag("night_visitor_complete")
			phase = "visitor_complete"
			show_end()
		"shion_arrival":
			play("shion_memory")
		"shion_memory":
			play("shion_close")
		"shion_close":
			GameState.set_flag("shion_first_session_seen")
			phase = "shion_complete"
			show_end()
		"miyako_seal":
			GameState.set_flag("miyako_seal_complete")
			phase = "seal_complete"
			show_end()
		"miyako_tea":
			GameState.set_flag("miyako_tea_complete")
			phase = "tea_complete"
			show_end()

func start_tea(checkpoint := false) -> void:
	if not checkpoint and (phase != "seal_complete" or not continue_armed or get_tree().paused):
		return
	if is_instance_valid(end_card):
		end_card.queue_free()
	GameState.set_story_time(3,"evening")
	GameState.visit_location("home")
	set_location("interior","Miyako · Egy este szerepek nélkül")
	runner.street.backdrop.modulate = Color(0.8,0.72,0.72)
	play("miyako_tea")

func start_day3_village() -> void:
	if phase != "seal_complete" or not continue_armed or get_tree().paused:
		return
	if GameState.day != 3 or GameState.time_of_day != "afternoon":
		return
	if is_instance_valid(end_card):
		end_card.queue_free()
	phase = "day3_village"
	afternoon_walk = preload("res://scripts/opening/village_walk_director.gd").new()
	add_child(afternoon_walk)
	afternoon_walk.runner = runner
	afternoon_walk.chapter = chapter
	afternoon_walk.completed.connect(finish_day3_village)
	afternoon_walk.begin()

func finish_day3_village() -> void:
	if phase != "day3_village":
		return
	afternoon_walk = null
	GameState.set_flag("day3_village_returned_home")
	phase = "seal_complete"
	continue_armed = true
	start_tea()

func start_seal() -> void:
	if phase != "shion_complete" or not continue_armed or get_tree().paused:
		return
	end_card.queue_free()
	set_location("clinic","Miyako · A pecsét")
	GameState.set_story_time(3,"afternoon")
	runner.street.backdrop.modulate = Color.WHITE
	play("miyako_seal")

func start_shion(checkpoint := false) -> void:
	if not checkpoint and (phase != "visitor_complete" or not continue_armed or get_tree().paused):
		return
	if is_instance_valid(end_card):
		end_card.queue_free()
	set_location("clinic","Másnap · Shion · 10:00")
	GameState.set_story_time(3,"clinic")
	GameState.visit_location("clinic")
	runner.street.backdrop.modulate = Color.WHITE
	runner.ambience.rain.stop()
	play("shion_arrival")

func start_night_visitor(checkpoint := false) -> void:
	if not checkpoint and (phase != "afternoon_complete" or not continue_armed or get_tree().paused):
		return
	if is_instance_valid(end_card):
		end_card.queue_free()
	set_location("clinic","Az éjszakai látogató")
	GameState.set_story_time(2,"night")
	GameState.visit_location("clinic")
	runner.street.backdrop.modulate = Color(0.42,0.48,0.64)
	runner.ambience.rain.stop()
	play("night_visitor")

func start_afternoon() -> void:
	if phase != "hana_complete" or not continue_armed or get_tree().paused:
		return
	end_card.queue_free()
	set_location("clinic","Késő délután · Miyako")
	GameState.set_story_time(2,"afternoon")
	runner.street.backdrop.modulate = Color(0.82,0.76,0.78)
	play("miyako_afternoon")

func show_end() -> void:
	chapter.hide_actors()
	var card := Control.new()
	end_card = card
	continue_armed = false
	chapter.presentation.add_child(card)
	var shade := ColorRect.new()
	shade.size = Vector2(640,360)
	shade.color = Color(0.01,0.02,0.04,0.85)
	card.add_child(shade)
	var title := Label.new()
	title.text = "Hana első beszélgetése lezárult" if phase == "hana_complete" else "Késő délután\nA jel Akira csuklóján"
	if phase == "visitor_complete":
		title.text = "Az éjszakai látogató\nFolytatás: Shion időpontja"
	if phase == "shion_complete":
		title.text = "Shion · A közös emlék\nAz első konzultáció lezárult"
	if phase == "seal_complete":
		title.text = "A pecsét\nAz első név visszatért"
	if phase == "tea_complete":
		title.text = "Miyako · Esti tea\nEgy személyesebb beszélgetés"
	title.position = Vector2(30,130)
	title.size = Vector2(580,50)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size",24)
	card.add_child(title)
	var button := Button.new()
	button.text = "Főmenü"
	button.position = Vector2(235,225)
	button.size = Vector2(170,38)
	button.pressed.connect(chapter.return_to_main)
	card.add_child(button)
	if phase in ["hana_complete","afternoon_complete","visitor_complete","shion_complete","seal_complete"]:
		button.position.y = 277
		continue_button = Button.new()
		continue_button.text = "Késő délután · Miyako" if phase == "hana_complete" else "Az éjszakai látogató"
		if phase == "visitor_complete":
			continue_button.text = "Másnap · Shion konzultációja"
		if phase == "shion_complete":
			continue_button.text = "Miyako visszatérése · A pecsét"
		if phase == "seal_complete":
			continue_button.text = "Délután · vissza a faluba"
		continue_button.position = Vector2(180,225)
		continue_button.size = Vector2(280,38)
		continue_button.disabled = true
		if phase == "hana_complete":
			continue_button.pressed.connect(start_afternoon)
		elif phase == "afternoon_complete":
			continue_button.pressed.connect(start_night_visitor)
		elif phase == "visitor_complete":
			continue_button.pressed.connect(start_shion)
		elif phase == "shion_complete":
			continue_button.pressed.connect(start_seal)
		else:
			continue_button.pressed.connect(start_day3_village)
		card.add_child(continue_button)

func advance(_delta: float) -> void:
	if phase in ["hana_complete","afternoon_complete","visitor_complete","shion_complete","seal_complete"] and not continue_armed:
		if not Input.is_action_pressed("observe") and not Input.is_key_pressed(KEY_SPACE) and not Input.is_key_pressed(KEY_ENTER) and not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			continue_armed = true
			continue_button.disabled = false
			continue_button.grab_focus()
