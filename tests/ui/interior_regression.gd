extends Node
var failures: Array[String] = []
func check(ok: bool, message: String) -> void:
	if not ok:
		failures.append(message)
		push_error(message)
func key(code: Key) -> void:
	var event := InputEventKey.new()
	event.keycode = code
	event.physical_keycode = code
	event.pressed = true
	Input.parse_input_event(event)
	await get_tree().process_frame
	event = InputEventKey.new()
	event.keycode = code
	event.physical_keycode = code
	Input.parse_input_event(event)
	await get_tree().process_frame
func _ready() -> void:
	for branch in 2:
		GameState.clear_runtime_state()
		var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
		add_child(runner)
		runner.skip_all()
		runner.street.show_location("house")
		runner.street.player.position = Vector2(275,274)
		runner.arrival = load("res://scripts/opening/arrival_director.gd").new()
		runner.add_child(runner.arrival)
		runner.arrival.runner = runner
		runner.arrival.done = true
		runner.arrival.show_miyako()
		GameState.set_flag("met_miyako")
		await key(KEY_E)
		check(not runner.street.player.input_enabled,"Entry locks movement")
		await get_tree().create_timer(1.1).timeout
		check(runner.street.location == "interior" and GameState.has_flag("entered_shared_home"),"Explicit E enters interior")
		check(not runner.weather.visible and runner.ambience.rain.volume_db < -20,"Rain remains outdoors")
		var vn: CanvasLayer = runner.arrival.vn
		while not vn.choice_box.visible:
			await key(KEY_SPACE)
			check(vn.body.get_line_count()*vn.body.get_line_height() <= vn.body.size.y,"All interior dialogue fits")
		check(GameState.miyako_first_choice.is_empty(),"No default choice is committed")
		await RenderingServer.frame_post_draw
		get_viewport().get_texture().get_image().save_png("res://review/interior_choice.png")
		if branch == 1:
			await key(KEY_DOWN)
		await key(KEY_ENTER)
		check(not vn.choice_box.visible and vn.index == 0,"Choice enters branch without skipping first line")
		var expected := "listen" if branch == 0 else "ask"
		check(GameState.miyako_first_choice == expected,"Keyboard chooses correct branch")
		check(GameState.aff_miyako == (1 if branch == 0 else 0) and GameState.akira_gyogyulas == (1 if branch == 0 else 0),"Canonical effects applied")
		runner.arrival.on_choice(expected)
		check(GameState.aff_miyako <= 1,"Choice effect cannot apply twice")
		while vn.active:
			await key(KEY_SPACE)
		check(GameState.has_flag("miyako_interior_dialogue_seen") and runner.street.player.input_enabled,"Branch completion returns control")
		Input.action_press("walk_down")
		await get_tree().create_timer(0.4).timeout
		Input.action_release("walk_down")
		check(runner.street.player.position.y <= 269,"Interior feet stay on the floor")
		Input.action_press("walk_right")
		await get_tree().create_timer(3.0).timeout
		Input.action_release("walk_right")
		check(runner.street.player.position.x > 340,"Player can walk past Miyako on the floor")
		Input.action_press("walk_left")
		await get_tree().create_timer(3.0).timeout
		Input.action_release("walk_left")
		check(runner.street.player.position.x < 240,"Player can pass Miyako in reverse too")
		await RenderingServer.frame_post_draw
		get_viewport().get_texture().get_image().save_png("res://review/interior_complete.png")
		runner.street.player.position = Vector2(460,266)
		await key(KEY_E)
		await get_tree().create_timer(0.9).timeout
		check(runner.street.location == "akira_room","Evening opens Akira's playable room")
		runner.street.player.position = Vector2(490,276)
		await key(KEY_E)
		var night: CanvasLayer = runner.arrival.vn
		check(night.active and not night.portrait.visible,"Next interaction starts night narration without Miyako portrait")
		while is_instance_valid(night) and night.active:
			check(night.next_button.visible,"Narration has a visible advance button")
			night.next_button.pressed.emit()
			await get_tree().process_frame
			if is_instance_valid(night):
				check(night.body.get_line_count()*night.body.get_line_height() <= night.body.size.y,"Night text fits")
		check(GameState.has_flag("first_night_seen"),"Night closes only after final acknowledgement")
		runner.queue_free()
		await get_tree().process_frame
	GameState.clear_runtime_state()
	check(GameState.aff_miyako == 0 and GameState.miyako_first_choice.is_empty(),"New game clears choices")
	print("INTERIOR: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
