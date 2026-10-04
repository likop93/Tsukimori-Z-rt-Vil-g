extends Node
var failures: Array[String] = []
func check(ok: bool, message: String) -> void:
	if not ok:
		failures.append(message)
		push_error(message)
func finish(vn: CanvasLayer, choice := "") -> void:
	for step in 300:
		if not is_instance_valid(vn) or not vn.active:
			return
		if vn.choice_box.visible:
			var options: Array = vn.choices
			for option in options:
				if option.id == choice:
					vn.select_choice(option)
					break
		else:
			vn.advance()
		await get_tree().process_frame
		if is_instance_valid(vn) and vn.active:
			check(vn.body.get_line_count()*vn.body.get_line_height() <= vn.body.size.y,"Dialogue fits: "+vn.body.text)
			check(vn.body.position.y+vn.body.size.y <= vn.next_button.position.y-4,"Dialogue stays clear of continue button: "+vn.body.text)
	check(false,"Dialogue failed to terminate")
func capture(file: String) -> void:
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/"+file+".png")
func interact() -> void:
	Input.action_press("observe")
	await get_tree().process_frame
	await get_tree().process_frame
	Input.action_release("observe")
	await get_tree().process_frame
func _ready() -> void:
	for branch in 2:
		GameState.clear_runtime_state()
		var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
		add_child(runner)
		runner.skip_all()
		var previous: Node = runner.arrival
		var night: Node = load("res://scripts/opening/first_night_director.gd").new()
		runner.arrival = night
		runner.add_child(night)
		night.runner = runner
		night.begin()
		if is_instance_valid(previous):
			previous.queue_free()
		await get_tree().process_frame
		await finish(night.vn)
		check(runner.street.location == "akira_room" and runner.street.player.input_enabled,"Room exploration returns control")
		check(not GameState.has_flag("first_night_seen"),"Room entry does not finish night")
		await capture("night_room_REVIEW")
		runner.street.player.position = Vector2(130,276)
		await interact()
		await finish(night.vn)
		check(GameState.has_flag("night_window_seen"),"Window observation acknowledged")
		runner.street.player.position = Vector2(210,276)
		await interact()
		await finish(night.vn)
		check(GameState.has_flag("night_bag_seen"),"Professional bag observation acknowledged")
		runner.street.player.position = Vector2(90,276)
		await interact()
		check(night.phase == "evening_living" and (not is_instance_valid(runner.street.featured_actor) or not runner.street.featured_actor.visible),"Living room remains accessible after Miyako retires")
		await interact()
		check(night.phase == "room","E returns to bedroom")
		runner.street.player.position = Vector2(310,276)
		await interact()
		check(night.phase == "photo","E at desk opens photo")
		await capture("night_photo_REVIEW")
		await finish(night.vn)
		check(GameState.has_flag("katsuro_first_clue_seen"),"Photo acknowledgement records clue")
		runner.street.player.position = Vector2(490,276)
		await interact()
		runner.pause_menu.open_menu()
		await get_tree().create_timer(0.5).timeout
		check(night.phase == "settling","Menu pauses bedtime transition")
		runner.pause_menu.resume()
		await get_tree().create_timer(1.0).timeout
		check(night.phase == "night","E at bed starts night")
		check(not runner.street.player.visible,"No standing sprite remains during sleep")
		night.vn.advance()
		await capture("night_sleep_REVIEW")
		Input.action_press("observe")
		await finish(night.vn)
		await get_tree().process_frame
		check(not night.card_armed,"Held dialogue input cannot arm morning")
		night.start_first_day()
		check(night.phase == "dawn_card","Held input cannot bypass ending")
		Input.action_release("observe")
		check(GameState.has_flag("first_night_seen") and night.phase == "dawn_card","Night has a separate acknowledged ending")
		check(GameState.has_flag("opening_prologue_complete") and not GameState.has_flag("first_clinic_day_started"),"Prologue ends before clinic starts")
		check(GameState.has_flag("night_voice_noticed"),"Canonical ambiguous voice beat is included")
		await capture("night_complete_REVIEW")
		await get_tree().process_frame
		var continue_key := InputEventKey.new()
		continue_key.keycode = KEY_SPACE
		continue_key.pressed = true
		Input.parse_input_event(continue_key)
		await get_tree().process_frame
		continue_key = InputEventKey.new()
		continue_key.keycode = KEY_SPACE
		continue_key.pressed = false
		Input.parse_input_event(continue_key)
		check(night.phase == "morning","Explicit continuation starts morning")
		check(not runner.street.player.input_enabled,"Morning dialogue locks movement")
		await capture("morning_REVIEW")
		await finish(night.vn,"stay" if branch == 0 else "withdraw")
		check(GameState.has_flag("miyako_morning_seen"),"Morning is acknowledged")
		var affinity: int = GameState.aff_miyako
		night.on_choice("stay")
		check(GameState.aff_miyako == affinity,"Morning effect cannot be repeated")
		await finish(night.vn,"empathy" if branch == 0 else "clinical")
		check(GameState.aff_miyako == (1 if branch == 0 else 0),"Canonical morning affinity")
		check(GameState.aff_hana == (1 if branch == 0 else 0),"Canonical clinic effect")
		check(GameState.akira_gyogyulas == (2 if branch == 0 else 0),"Canonical healing effects")
		check(runner.street.location == "clinic" and runner.street.player.input_enabled,"Clinic opens as playable scene")
		check(not GameState.has_flag("first_clinic_day_seen"),"Starting day does not complete consultations")
		await capture("clinic_REVIEW")
		for i in 2:
			runner.street.player.position = Vector2(310,276)
			await interact()
			check(night.phase == "patient","E opens next consultation")
			check(not runner.street.player.input_enabled,"Consultation locks movement")
			await finish(night.vn)
			check(GameState.has_flag("first_day_consultation_%d_seen" % (i+1)),"Acknowledged consultation recorded")
			check(GameState.has_flag("first_clinic_day_seen") == (i == 1),"Day completes only after second consultation")
		var grounded: Vector2 = runner.street.constrain_position(Vector2(1000,0))
		check(grounded == Vector2(495,272),"Clinic feet remain inside clear floor strip")
		runner.street.player.position = Vector2(310,276)
		await interact()
		check(night.phase == "day_reflection","Completed consultations open reflection")
		check(not GameState.has_flag("first_day_complete"),"Consultations alone do not complete the whole day")
		await finish(night.vn)
		check(GameState.has_flag("katsuro_clinic_notebook_seen"),"Notebook clue records only after acknowledgement")
		check(night.phase == "clinic_after","Reflection leaves a walkable clinic")
		runner.street.player.position = Vector2(90,276)
		await interact()
		check(night.phase == "day_evening_walk" and runner.street.location == "interior","Clinic returns to shared living room")
		runner.street.player.position = Vector2(300,266)
		await interact()
		check(night.phase == "day_evening","E at Miyako opens evening VN")
		night.vn.advance()
		await capture("first_day_evening_REVIEW")
		await finish(night.vn)
		check(night.phase == "day_hook" and not runner.street.player.visible,"Second night uses cinematic presentation without standing sprite")
		await finish(night.vn)
		check(GameState.has_flag("first_day_complete") and night.phase == "day_complete","Day ends after its hook")
		check(GameState.has_flag("hana_name_heard") and not GameState.has_flag("met_hana"),"Heard name does not invent a Hana meeting")
		var journal: Array[Dictionary] = preload("res://scripts/ui/character_journal.gd").entries()
		var self_entry: Dictionary = journal.filter(func(item: Dictionary): return item.id == "akira")[0]
		check("Éjszaka a Hana nevet hallottad." in self_entry.events,"Journal records only the heard name")
		await capture("first_day_complete_REVIEW")
		runner.queue_free()
		await get_tree().process_frame
	GameState.clear_runtime_state()
	check(not GameState.has_flag("first_day_complete") and not GameState.has_flag("hana_name_heard"),"New game clears first-day progress")
	print("NIGHT_DAY: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
