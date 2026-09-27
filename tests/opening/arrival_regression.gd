extends Node
var failures: Array[String] = []
func check(ok: bool, label: String) -> void:
	if not ok:
		failures.append(label)
		push_error(label)
func capture(label: String) -> void:
	if DisplayServer.get_name() != "headless":
		await RenderingServer.frame_post_draw
		get_viewport().get_texture().get_image().save_png("res://review/"+label+".png")
func make_runner() -> Node:
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	await get_tree().process_frame
	return runner
func check_watchers(runner: Node, place: String) -> void:
	var watchers := 0
	for resident in runner.street.residents:
		if resident.visible and resident.state == "look":
			watchers += 1
	check(watchers >= 2,"At least two live women watch Akira in "+place)
func _ready() -> void:
	GameState.clear_runtime_state()
	var runner: Node = await make_runner()
	runner.auto_advance = false
	runner.finish_intro()
	check(not runner.street.player.input_enabled,"Street remains cinematic")
	Input.action_press("walk_down")
	var initial_y: float = runner.street.player.position.y
	await get_tree().create_timer(1.0).timeout
	Input.action_release("walk_down")
	check(runner.street.player.position.y < initial_y,"Director moves actor while opposing player input is ignored")
	runner.request_skip()
	check(runner.skip_dialog.visible,"Unseen arrival asks before skipping")
	await get_tree().process_frame
	var paused: Vector2 = runner.street.player.position
	await get_tree().create_timer(0.2).timeout
	check(runner.street.player.position.distance_to(paused) < 1,"Skip confirmation pauses actor")
	runner.skip_dialog.hide()
	await capture("arrival_street_cinematic")
	check_watchers(runner,"street")
	Engine.time_scale = 4
	while runner.arrival.phase == "street":
		await get_tree().process_frame
	check(not runner.street.player.input_enabled,"Bridge remains cinematic")
	await get_tree().create_timer(5).timeout
	await capture("arrival_bridge_cinematic")
	check_watchers(runner,"bridge")
	while runner.arrival.phase == "bridge":
		await get_tree().process_frame
	check(runner.street.player.position.x < 200,"Akira enters the house shot from the left")
	while runner.arrival.phase != "greeting":
		await get_tree().process_frame
	check(not GameState.has_flag("met_miyako"),"Meeting is not set before greeting")
	await get_tree().create_timer(4).timeout
	await capture("arrival_miyako_greeting")
	check_watchers(runner,"house")
	check(runner.street.player.position.x < runner.arrival.miyako.position.x and runner.street.player.facing == 3,"Akira stops left of Miyako facing toward her")
	check(runner.narration.text.contains("Dr. Akira. Már vártam."),"Canonical greeting is displayed")
	while not runner.arrival.done:
		await get_tree().process_frame
	Engine.time_scale = 1
	check(runner.street.player.input_enabled and runner.handoff_count == 1,"One natural handoff after greeting")
	var destination: Vector2 = runner.street.player.position
	Input.action_press("walk_left")
	await get_tree().create_timer(0.4).timeout
	Input.action_release("walk_left")
	check(runner.street.player.position.x < destination.x,"House forecourt becomes playable")
	runner.queue_free()
	await get_tree().process_frame
	for phase in ["intro","street","bridge","house","greeting"]:
		GameState.clear_runtime_state()
		runner = await make_runner()
		if phase != "intro":
			runner.finish_intro()
			if phase in ["house","greeting"]:
				runner.arrival.enter_phase("house")
			if phase != "street":
				runner.arrival.enter_phase(phase)
		runner.skip_all()
		runner.skip_all()
		check(runner.street.location == "house" and runner.handoff_count == 1,"Skip endpoint is idempotent from "+phase)
		check(runner.street.player.position.x == 270 and runner.street.player.facing == 3,"Skipped arrival retains left-hand staging")
		for flag in ["opening_intro_seen","entered_tsukimori","crossed_bridge","met_miyako","arrival_cinematic_seen"]:
			check(GameState.has_flag(flag),"Skip sets "+flag+" from "+phase)
		runner.queue_free()
		await get_tree().process_frame
	print("ARRIVAL_REGRESSION: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
