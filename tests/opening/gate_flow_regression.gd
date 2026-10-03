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
func interact() -> void:
	Input.action_press("observe")
	await get_tree().process_frame
	await get_tree().process_frame
	Input.action_release("observe")
	await get_tree().process_frame
func _ready() -> void:
	GameState.clear_runtime_state()
	var runner: Node = await make_runner()
	var duration := 0.0
	var beat_count: int = runner.beats.size()
	for beat in runner.beats:
		duration += float(beat.duration)
	check(duration >= 45 and duration <= 70,"Opening is 45–70 seconds")
	var start: Vector2 = runner.street.player.position
	Input.action_press("walk_right")
	await get_tree().create_timer(0.2).timeout
	Input.action_release("walk_right")
	check(runner.street.player.position.is_equal_approx(start),"Opening blocks player input")
	Engine.time_scale = 4
	var captured := {}
	while not runner.completed:
		var beat: Dictionary = runner.beats[runner.beat_index]
		if runner.beat_time > float(beat.duration)*0.65 and not captured.has(beat.id):
			captured[beat.id] = true
			await capture("short_intro_"+str(beat.id))
		await get_tree().process_frame
	Engine.time_scale = 1
	check(runner.street.location == "street" and runner.street.player.input_enabled,"Natural handoff is at village entrance")
	check(runner.dialogue.modulate.a == 1.0,"Natural handoff restores dialogue opacity")
	check(runner.handoff_count == 1 and not GameState.has_flag("met_miyako") and not GameState.has_flag("crossed_bridge"),"Gate handoff does not invent later story progress")
	await capture("short_intro_playable_gate")
	# The street must remain still until the player provides input.
	start = runner.street.player.position
	await get_tree().create_timer(0.4).timeout
	check(runner.street.player.position.distance_to(start) < 0.1,"No automatic village walk remains")
	Input.action_press("walk_up")
	await get_tree().create_timer(2.5).timeout
	Input.action_release("walk_up")
	await get_tree().create_timer(0.2).timeout
	check(runner.street.player.position.y == 150,"Player cannot walk up painted background stairs")
	await interact()
	check(runner.street.location == "bridge","Player explicitly enters bridge")
	Input.action_press("walk_right")
	await get_tree().create_timer(3.4).timeout
	Input.action_release("walk_right")
	await capture("bridge_grounding_REVIEW")
	check(runner.street.bridge_rail.visible and runner.street.player.position.y >= 177 and runner.street.player.position.y <= 183,"Bridge feet stay on the deck behind the near rail")
	await get_tree().create_timer(2.7).timeout
	check(runner.street.player.input_enabled,"Bridge microbeat returns control")
	Input.action_press("walk_right")
	await get_tree().create_timer(4).timeout
	Input.action_release("walk_right")
	await get_tree().create_timer(0.3).timeout
	await interact()
	check(runner.street.location == "house" and GameState.has_flag("crossed_bridge"),"House follows player crossing")
	check(runner.street.player.position.x < 200 and not GameState.has_flag("met_miyako"),"House entry remains on the left without premature meeting")
	Input.action_press("walk_right")
	await get_tree().create_timer(1.85).timeout
	Input.action_release("walk_right")
	await get_tree().create_timer(0.3).timeout
	check(runner.street.player.visual.frame == 3 and not runner.street.player.visual.flip_h,"Right idle preserves direction")
	await interact()
	Engine.time_scale = 4
	await get_tree().create_timer(4).timeout
	check(runner.arrival.vn.body.text.contains("Dr. Akira. Már vártam."),"Miyako meeting is still available after exploration")
	check(runner.arrival.vn.root.is_visible_in_tree(),"Miyako VN actually renders after natural intro")
	await capture("miyako_after_exploration_REVIEW")
	await get_tree().create_timer(7).timeout
	check(not GameState.has_flag("met_miyako") and not runner.street.player.input_enabled,"VN waits for player instead of timing out")
	while runner.arrival.vn.active:
		runner.arrival.vn.advance()
	Engine.time_scale = 1
	check(GameState.has_flag("met_miyako") and runner.street.player.input_enabled,"Meeting alone sets met_miyako and returns control")
	Input.action_press("walk_left")
	await get_tree().create_timer(0.5).timeout
	Input.action_release("walk_left")
	await get_tree().create_timer(0.4).timeout
	check(runner.street.player.visual.frame == 1 and not runner.street.player.visual.flip_h,"Left idle no longer flips to right")
	await capture("akira_left_idle_REVIEW")
	runner.queue_free()
	await get_tree().process_frame
	for index in beat_count:
		GameState.clear_runtime_state()
		runner = await make_runner()
		runner.auto_advance = false
		runner.set_beat(index)
		runner.request_skip()
		check(runner.skip_dialog.visible,"Unseen intro asks confirmation")
		runner.skip_dialog.confirmed.emit()
		runner.skip_all()
		check(runner.handoff_count == 1 and runner.street.location == "street" and runner.street.player.input_enabled,"Every skip reaches gate exactly once")
		check(runner.dialogue.modulate.a == 1.0,"Skip restores dialogue opacity")
		check(GameState.has_flag("opening_intro_seen") and GameState.has_flag("entered_tsukimori") and not GameState.has_flag("met_miyako") and not GameState.has_flag("crossed_bridge"),"Skip flags match new governance")
		runner.queue_free()
		await get_tree().process_frame
	var report := {"suite":"gate_flow","passed":failures.is_empty(),"failures":failures,"intro_seconds":duration}
	FileAccess.open("res://review/test_results.json",FileAccess.WRITE).store_string(JSON.stringify(report,"  "))
	print("GATE_FLOW_REGRESSION: "+JSON.stringify(report))
	get_tree().quit(0 if failures.is_empty() else 1)
