extends Node
var failures: Array[String] = []
var miyako_reactions: Dictionary = {}
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
			if vn.portrait.visible and vn.portrait_speaker == "Miyako":
				miyako_reactions[vn.portrait_source_path] = true
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
func choose(night: Node, label: String) -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	for button in night.action_buttons:
		if button.text == label:
			check(not button.disabled,"Action is armed: "+label)
			button.grab_focus()
			var press := InputEventKey.new()
			press.keycode = KEY_ENTER
			press.physical_keycode = KEY_ENTER
			press.pressed = true
			Input.parse_input_event(press)
			await get_tree().process_frame
			var release := InputEventKey.new()
			release.keycode = KEY_ENTER
			release.physical_keycode = KEY_ENTER
			Input.parse_input_event(release)
			await get_tree().process_frame
			return
	check(false,"Missing action: "+label)
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
		check(runner.street.location == "akira_room" and not runner.street.player.input_enabled and not runner.street.player.visible,"Room uses VN backdrop without walking sprite")
		check(not GameState.has_flag("first_night_seen"),"Room entry does not finish night")
		await capture("night_room_REVIEW")
		var stationary: Vector2 = runner.street.player.position
		Input.action_press("walk_right")
		await get_tree().create_timer(0.2).timeout
		Input.action_release("walk_right")
		check(runner.street.player.position == stationary,"Movement cannot move hidden actor in VN room")
		await choose(night,"Az ablakhoz fordulok")
		await finish(night.vn)
		check(GameState.has_flag("night_window_seen"),"Window observation acknowledged")
		await choose(night,"Megnézem az orvosi táskát")
		await finish(night.vn)
		check(GameState.has_flag("night_bag_seen"),"Professional bag observation acknowledged")
		await choose(night,"Vissza a nappaliba")
		check(night.phase == "evening_living" and (not is_instance_valid(runner.street.featured_actor) or not runner.street.featured_actor.visible),"Living room remains accessible after Miyako retires")
		await interact()
		check(night.phase == "room","E returns to bedroom")
		await choose(night,"Megnézem a fényképet")
		check(night.phase == "photo","E at desk opens photo")
		await capture("night_photo_REVIEW")
		await finish(night.vn)
		check(GameState.has_flag("katsuro_first_clue_seen"),"Photo acknowledgement records clue")
		await choose(night,"Lefekszem")
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
		check(runner.street.location == "clinic" and not runner.street.player.input_enabled and not runner.street.player.visible,"Clinic uses VN backdrop without walking sprite")
		check(not GameState.has_flag("first_clinic_day_seen"),"Starting day does not complete consultations")
		await capture("clinic_REVIEW")
		for i in 2:
			await choose(night,"Első konzultáció" if i == 0 else "Második konzultáció")
			check(night.phase == "patient","E opens next consultation")
			check(night.vn.portrait.visible and night.vn.akira_portrait.visible,"Both consultation participants have portraits")
			check(night.vn.portrait_source_path.ends_with("patient_%d_neutral_v1_REVIEW.png" % (i+1)),"Each anonymous patient has her own source portrait")
			check(night.vn.portrait_speaker == "Páciens","Patient remains anonymous")
			night.vn.advance()
			await capture("patient_%d_portrait_REVIEW" % (i+1))
			check(not runner.street.player.input_enabled,"Consultation locks movement")
			await finish(night.vn)
			check(GameState.has_flag("first_day_consultation_%d_seen" % (i+1)),"Acknowledged consultation recorded")
			check(GameState.has_flag("first_clinic_day_seen") == (i == 1),"Day completes only after second consultation")
		await choose(night,"Átgondolom a napot")
		check(night.phase == "day_reflection","Completed consultations open reflection")
		check(not GameState.has_flag("first_day_complete"),"Consultations alone do not complete the whole day")
		await finish(night.vn)
		check(GameState.has_flag("katsuro_clinic_notebook_seen"),"Notebook clue records only after acknowledgement")
		check(night.phase == "clinic_after","Reflection leaves an explicit continuation")
		await choose(night,"Visszatérek Miyakóhoz")
		check(night.phase == "day_evening" and not runner.street.player.visible,"Continuation opens evening VN without tiny actor")
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
	check(miyako_reactions.size() >= 4,"Miyako shows four reactions during the actual morning and evening sequence")
	check(not GameState.has_flag("first_day_complete") and not GameState.has_flag("hana_name_heard"),"New game clears first-day progress")
	print("NIGHT_DAY: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
