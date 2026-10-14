extends "res://tests/ui/night_day_regression.gd"

func _ready() -> void:
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
	var before := GameState.flags.duplicate(true)
	var position: Vector2 = runner.street.player.position
	var rain_db: float = runner.ambience.rain.volume_db
	await choose(night,"Kinézek a folyosóra · REVIEW")
	var hall: Node = night.hallway
	check(night.phase == "hallway" and is_instance_valid(hall),"Room action starts optional hallway")
	check(not night.start_hallway(),"Duplicate start rejected while running")
	check(not hall.begin(),"Director cannot start twice")
	check(not GameState.has_flag(hall.SEEN),"Starting does not prematurely mark seen")
	await get_tree().create_timer(1.0).timeout
	check(hall.cue.playing,"Existing wood cue is playing")
	await capture("hallway_01_REVIEW")
	runner.pause_menu.open_menu()
	await get_tree().process_frame
	var frozen: float = hall.animation.current_animation_position
	var camera_at: Vector2 = hall.camera.position
	await get_tree().create_timer(0.6).timeout
	check(is_equal_approx(hall.animation.current_animation_position,frozen),"Pause freezes animation timeline")
	check(hall.camera.position == camera_at,"Pause freezes camera")
	check(hall.cue.stream_paused,"Pause suspends creak audio")
	runner.pause_menu.resume()
	Input.action_press("walk_right")
	var space := InputEventKey.new()
	space.keycode = KEY_SPACE
	space.pressed = true
	Input.parse_input_event(space)
	await get_tree().create_timer(2.3).timeout
	space.pressed = false
	Input.parse_input_event(space)
	Input.action_release("walk_right")
	check(not is_instance_valid(hall.vn),"Space does not skip timed staging")
	check(runner.street.player.position == position,"Hidden Akira cannot walk or jump")
	await capture("hallway_03_REVIEW")
	while hall.animation.current_animation_position < 7.2:
		await get_tree().process_frame
	check(is_equal_approx(hall.turn,2.0),"Turn finishes at seven seconds")
	await capture("hallway_07_REVIEW")
	while hall.animation.current_animation_position < 12.0:
		await get_tree().process_frame
	check(hall.smile > 0.5 and hall.camera.zoom.x > 1.025,"Small smile and camera push at twelve seconds")
	check(hall.poses[2].modulate.a == 1.0,"Expression transition keeps the body opaque")
	await capture("hallway_12_REVIEW")
	while hall.animation.current_animation_position < 13.65:
		await get_tree().process_frame
	check(hall.blink > 0.9,"Blink closes naturally")
	await capture("hallway_blink_REVIEW")
	while not is_instance_valid(hall.vn):
		await get_tree().process_frame
	check(is_equal_approx(hall.animation.get_animation("hallway").length,16.0),"Sixteen-second real animation completed")
	check(hall.smile == 0.0 and hall.blink == 0.0,"Face settles before dialogue")
	check(hall.vn.lines.size() == 3 and hall.vn.index == 0,"Existing VN starts exact three-line dialogue")
	await get_tree().create_timer(2.0).timeout
	check(hall.vn.index == 0,"Dialogue waits for reader")
	runner.pause_menu.open_menu()
	var revealed: float = hall.vn.revealed
	await get_tree().create_timer(0.4).timeout
	check(hall.vn.revealed == revealed,"Pause freezes VN text")
	runner.pause_menu.resume()
	await capture("hallway_dialogue_REVIEW")
	await finish(hall.vn)
	await get_tree().process_frame
	check(night.phase == "room" and night.actions.visible,"Returns to room choices")
	check(not runner.street.player.input_enabled,"Room remains VN controlled")
	check(GameState.has_flag("miyako_hallway_glimpse_seen"),"Reader completion marks seen")
	check(not night.start_hallway(),"Completed event cannot repeat")
	check(not night.action_buttons.any(func(button: Button): return "folyosó" in button.text),"Completed event removed from choices")
	check(GameState.flags.size() == before.size()+1,"Only one flag added")
	for key in before:
		check(GameState.flags.get(key) == before[key],"Preserves story flag: "+key)
	check(not GameState.has_flag("miyako_transformation_revealed"),"Transformation stays false")
	check(GameState.aff_miyako == 0 and GameState.aff_hana == 0 and GameState.aff_shion == 0 and GameState.akira_gyogyulas == 0 and GameState.akira_elmerules == 0,"No relationship or Akira stat rewards")
	check(GameState.horror_pressure == 0 and GameState.horror_events.is_empty() and GameState.personal_choices.is_empty(),"No horror or relationship event recorded")
	check(runner.ambience.rain.volume_db == rain_db and not runner.weather.active,"Existing indoor weather unchanged")
	await choose(night,"Vissza a nappaliba")
	check(runner.street.player.input_enabled,"Living-room movement still restored")
	runner.queue_free()
	await get_tree().process_frame
	GameState.clear_runtime_state()
	check(not GameState.has_flag("miyako_hallway_glimpse_seen"),"New game resets one-shot")
	print("MIYAKO_HALLWAY: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
