extends Node
var failures: Array[String] = []
var runner: Node
var shots := false

func check(ok: bool, message: String) -> void:
	if not ok:
		failures.append(message)
		push_error("FAIL: "+message)
	else:
		print("PASS: "+message)

func _ready() -> void:
	shots = DisplayServer.get_name() != "headless"
	await run_checks()

func new_runner() -> Node:
	var node: Node = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(node)
	await get_tree().process_frame
	return node

func capture(label: String) -> void:
	if shots:
		await RenderingServer.frame_post_draw
		var image := get_viewport().get_texture().get_image()
		image.save_png("res://review/"+label+".png")

func run_checks() -> void:
	GameState.clear_runtime_state()
	runner = await new_runner()
	runner.auto_advance = false
	var start: Vector2 = runner.street.player.position
	Input.action_press("walk_right")
	await get_tree().create_timer(0.15).timeout
	Input.action_release("walk_right")
	check(runner.street.player.position.is_equal_approx(start),"Input locked during intro")
	check(not GameState.has_flag("entered_tsukimori"),"No story flag before handoff")
	check(not runner.weather.visible,"Opening black beat has no visible rain overlay")
	var total := 0.0
	for beat in runner.beats:
		total += float(beat.duration)
	check(total >= 90 and total <= 180,"Automatic intro duration is 1.5–3 minutes")
	for index in range(6):
		runner.set_beat(index)
		if index > 0 and index < 5:
			await get_tree().create_timer(0.9).timeout
			runner.reveal_time = 100
			await capture("intro_"+str(index))
		runner.request_skip()
		check(runner.skip_dialog.visible,"First-run skip asks confirmation at beat "+str(index))
		runner.skip_dialog.hide()
	check(not runner.completed,"Cancelling skip retains input lock")
	# Exercise the real natural completion path, not only finish_intro().
	runner.auto_advance = true
	runner.beat_time = 2.49
	await get_tree().create_timer(0.12).timeout
	check(runner.completed and runner.handoff_count == 1,"Natural handoff occurs exactly once")
	check(GameState.has_flag("opening_intro_seen") and GameState.has_flag("entered_tsukimori"),"Both story flags set at natural handoff")
	check(runner.ambience.rain.playing,"Rain continues through handoff")
	check(runner.street.residents.size() == 4,"Four anonymous female residents instantiated")
	var sheet_paths: Dictionary = {}
	for resident in runner.street.residents:
		sheet_paths[resident.visual.texture.resource_path] = true
		var sheet: Image = resident.visual.texture.get_image()
		check(sheet.get_size() == Vector2i(256,192),"Individual eight-pose atlas loaded for "+str(resident.name))
		var registered := true
		for pose_index in range(8):
			var cell := sheet.get_region(Rect2i(Vector2i(pose_index%4,pose_index/4)*Vector2i(64,96),Vector2i(64,96)))
			var bounds := cell.get_used_rect()
			registered = registered and bounds.end.y == 94 and bounds.position.x > 0 and bounds.end.x < 64
			registered = registered and cell.get_pixel(0,0).a == 0
		check(registered,"All eight poses have transparent margins and fixed feet: "+str(resident.name))
	check(sheet_paths.size() == 4,"All four residents use their own approved sheet")
	await capture("village_start")
	var old_x: float = runner.street.player.position.x
	Input.action_press("walk_right")
	await get_tree().create_timer(3.4).timeout
	Input.action_release("walk_right")
	check(runner.street.player.position.x > old_x+100,"Player input moves Akira after handoff")
	check(runner.street.camera.position.x > 320,"Camera follows within scene limits")
	runner.street.player.position = Vector2(650,340)
	await get_tree().create_timer(1.6).timeout
	await capture("village_right")
	check(not runner.street.player.moving and runner.street.player.visual.frame < 4,"Akira returns to idle after stopping")
	var all_walk := true
	for frame in range(4,8):
		all_walk = all_walk and runner.street.player.visited_frames.has(frame)
	check(all_walk,"Akira plays every side-walk phase from actual travel")
	Input.action_press("walk_up")
	await get_tree().create_timer(1.0).timeout
	Input.action_release("walk_up")
	check(runner.street.player.position.y >= 322,"Cannot walk onto stairs or background bridge")
	check(not runner.street.player.moving and runner.street.player.visual.frame == 2,"Walking into upper boundary stops gait in back idle")
	runner.street.player.position = Vector2(650,350)
	for action in ["walk_up","walk_down","walk_left"]:
		Input.action_press(action)
		await get_tree().create_timer(0.4).timeout
		Input.action_release(action)
	var used_back := false
	var used_front := false
	for frame in range(8,12):
		used_front = used_front or runner.street.player.visited_frames.has(frame)
	for frame in range(12,16):
		used_back = used_back or runner.street.player.visited_frames.has(frame)
	check(used_front and used_back,"Depth movement uses front and back walking poses")
	check(runner.street.player.visual.flip_h,"Left walk faces left")
	runner.street.player.position = Vector2(733,370)
	Input.action_press("walk_right")
	Input.action_press("walk_down")
	await get_tree().create_timer(0.2).timeout
	Input.action_release("walk_right")
	Input.action_release("walk_down")
	check(runner.street.player.position.x <= 734 and runner.street.player.position.y <= 376,"Right and bottom bounds hold")
	for resident in runner.street.residents:
		check(resident.row >= 1 and resident.row <= 4,"Resident uses anonymous approved source row")
	runner.street.player.position = Vector2(280,330)
	# Start a fresh encounter independent of earlier movement-test duration.
	runner.street.residents[0].look_cooldown = 0.0
	await get_tree().create_timer(0.15).timeout
	check(runner.street.residents[0].state == "look","Resident notices nearby Akira")
	var looking_at: Vector2 = runner.street.residents[0].position
	await get_tree().create_timer(0.15).timeout
	check(runner.street.residents[0].position.is_equal_approx(looking_at),"Resident stops walking while looking at Akira")
	runner.finish_intro()
	check(runner.handoff_count == 1,"Repeated completion is idempotent")
	runner.queue_free()
	await get_tree().process_frame
	# Each beat can be skipped without missing required story state.
	for index in range(6):
		GameState.clear_runtime_state()
		runner = await new_runner()
		runner.auto_advance = false
		runner.set_beat(index)
		runner.request_skip()
		runner.skip_dialog.confirmed.emit()
		check(runner.completed and runner.street.player.input_enabled and GameState.has_flag("opening_intro_seen") and GameState.has_flag("entered_tsukimori"),"Confirmed skip is state-safe at beat "+str(index))
		runner.queue_free()
		await get_tree().process_frame
	GameState.set_flag("opening_intro_seen")
	runner = await new_runner()
	runner.request_skip()
	check(runner.completed and not runner.skip_dialog.visible,"Seen intro skips without confirmation")
	await get_tree().create_timer(2.2).timeout
	check(not runner.ambience.vehicle.playing,"Vehicle ambience stops after skip")
	var state_union: Dictionary = {}
	for resident in runner.street.residents:
		for key in resident.visited_states:
			state_union[key] = true
	# Independently exercise a full ambient cycle.
	runner.street.player.position = Vector2(120,360)
	await get_tree().create_timer(7.0).timeout
	for resident in runner.street.residents:
		for key in resident.visited_states:
			state_union[key] = true
	check(state_union.has("idle") and state_union.has("slow_walk"),"Ambient cycle contains idle and slow walk")
	for resident in runner.street.residents:
		check(absf(resident.position.x-resident.home_x) <= resident.roam_range+0.01,"Resident stays inside its patrol bounds: "+str(resident.name))
		if resident.behavior == "slow_walk":
			var all_phases := true
			for phase in range(4,8):
				all_phases = all_phases and resident.visited_frames.has(phase)
			check(all_phases,"Walking resident actually plays all four gait poses: "+str(resident.name))
	runner.queue_free()
	await get_tree().process_frame
	await get_tree().process_frame
	var report := {"failures":failures,"passed":failures.is_empty(),"renderer":DisplayServer.get_name(),"intro_seconds":total}
	FileAccess.open("res://review/test_results.json",FileAccess.WRITE).store_string(JSON.stringify(report,"  "))
	print("OPENING_REGRESSION_RESULT: "+JSON.stringify(report))
	get_tree().quit(0 if failures.is_empty() else 1)
