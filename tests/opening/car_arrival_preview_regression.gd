extends "res://tests/ui/night_day_regression.gd"
## Through the real menu, one story session from road to the first patient.
var runs: Array[Dictionary] = []

func _ready() -> void:
	get_window().unfocusable = true
	Engine.time_scale = 2.0
	for branch in 3:
		await journey(branch)
		if not failures.is_empty():
			break
	if runs.size() >= 2:
		check(runs[0] == runs[1],"Natural and Skip with identical choices reach identical story state")
	Engine.time_scale = 1.0
	await get_tree().create_timer(0.6).timeout
	print("CAR_STORY: ",JSON.stringify({"passed":failures.is_empty(),"failures":failures,"runs":runs}))
	get_tree().quit(0 if failures.is_empty() else 1)

func journey(branch: int) -> void:
	var tree := get_tree()
	GameState.set_flag("stale_test_sentinel")
	var menu: Node = preload("res://scenes/ui/main_menu.tscn").instantiate()
	tree.root.add_child.call_deferred(menu)
	await tree.process_frame
	tree.current_scene = menu
	menu.open_chapters()
	for button in menu.modal.get_children():
		if button is Button and button.text == "Autós nyitány · próba":
			button.pressed.emit()
			break
	await tree.scene_changed
	var film := tree.current_scene
	check(GameState.day == 0 and GameState.flags.is_empty(),"New trial begins at day zero")
	if branch != 2:
		for mark in [5.0,6.85,7.65,8.72,9.84]:
			while film.time < mark:
				await tree.process_frame
			if mark == 5.0:
				check(film.caption.text == "Katsuro hívott vissza.","Existing thought precedes the memory")
			else:
				check(not film.get_node("Subtitle").visible,"Memory and steering wheel have no extra explanation")
				if mark == 7.65:
					film.toggle_pause()
					var held: float = film.time
					film.skip_journey()
					await tree.create_timer(0.15,true).timeout
					check(film.time == held and not film.meeting_started,"Pause freezes flash and prevents skip")
					film.toggle_pause()
				if branch == 0:
					await capture("car_memory_"+str(mark).replace(".","_"))
				if branch == 1 and mark == 7.65:
					break
	if branch == 0:
		for mark in [26.6,31.6,39.6]:
			while film.time < mark:
				await tree.process_frame
			if mark == 26.6:
				check(film.still.texture == film.BRIDGE_FOOT and film.caption.text == "Csak a csendje lett nehezebb.","Bridge monologue and shot")
				check(film.brook.playing and film.ambience.cue_cursor >= 4 and film.ambience.cues[3].sound == "board2","Stream and change of surface")
			elif mark == 31.6:
				check(film.still.texture == film.SHION_BANK and not GameState.has_flag("met_shion"),"Shion is only observed")
			else:
				check(film.still.texture == film.HOUSE_WIDE,"Far-bank house and clinic")
		await tree.create_timer(2.5).timeout
		check(is_instance_valid(film.greeting.living_cg),"Natural route uses existing Living CG")
		await tree.create_timer(9.2).timeout
	else:
		film.skip_button.pressed.emit()
		film.skip_journey()
	var greeting: Node = film.greeting.vn
	check(greeting.active and greeting.index == 0 and greeting.body.text == "Dr. Akira. Már vártam.","Natural and Skip stop at first line")
	check(not GameState.has_flag("met_miyako") and not GameState.has_flag("entered_shared_home"),"No premature greeting or interior flags")
	check(GameState.aff_miyako == 0 and GameState.aff_shion == 0,"Presentation gives no affinity")
	if branch == 0:
		await capture("car_story_greeting")
	await finish(greeting)
	await tree.create_timer(0.85).timeout
	var runner := tree.current_scene
	check(runner.scene_file_path == "res://scenes/opening/opening.tscn","Greeting enters original story runner")
	if not runner.scene_file_path.ends_with("opening.tscn"):
		return
	check(runner.street.location == "interior" and GameState.has_flag("miyako_first_dialogue_seen") and GameState.has_flag("entered_shared_home"),"Existing interior starts")
	check(GameState.miyako_first_choice.is_empty() and not GameState.has_flag("first_night_started"),"Home choice pending")
	var warm := branch != 2
	await finish(runner.arrival.vn,"listen" if warm else "ask")
	await tree.process_frame
	var night: Node = runner.arrival
	check(night.phase == "room_arrival" and GameState.day == 0 and GameState.has_flag("visited_akira_room"),"Room follows the completed home choice on day zero")
	check(GameState.aff_miyako == (1 if warm else 0),"Interior reward exactly once")
	await finish(night.vn)
	await choose(night,"Lefekszem")
	check(night.phase == "photo","Sleep still requires the Katsuro clue")
	await finish(night.vn)
	await tree.create_timer(1.15).timeout
	await finish(night.vn)
	await tree.process_frame
	check(night.phase == "dawn_card" and GameState.day == 0 and GameState.has_flag("first_night_seen"),"Night ends before the day changes")
	night.start_first_day()
	check(GameState.day == 1 and GameState.time_of_day == "morning" and not GameState.has_flag("first_clinic_day_started"),"Day one morning precedes clinic")
	if branch == 0:
		await capture("car_story_morning")
	await finish(night.vn,"stay" if warm else "withdraw")
	await finish(night.vn,"empathy" if warm else "clinical")
	check(GameState.day == 1 and GameState.time_of_day == "clinic" and night.phase == "clinic","Morning leads to the existing clinic")
	check(GameState.aff_miyako == (2 if warm else 0) and GameState.aff_shion == (1 if warm else 0) and GameState.aff_hana == (1 if warm else 0) and GameState.akira_gyogyulas == (3 if warm else 0),"Original choice consequences")
	await choose(night,"Első konzultáció")
	await finish(night.vn)
	check(GameState.has_flag("first_day_consultation_1_seen") and not GameState.has_flag("met_shion"),"First patient completes; no Shion introduction")
	runs.append({"flags":GameState.flags.duplicate(true),"day":GameState.day,"time":GameState.time_of_day,"home_choice":GameState.miyako_first_choice,"morning_choice":GameState.miyako_morning_choice,"clinic_choice":GameState.clinic_first_choice,"scores":[GameState.aff_miyako,GameState.aff_hana,GameState.aff_shion,GameState.akira_gyogyulas]})
	runner.queue_free()
	await tree.process_frame
	await tree.process_frame
