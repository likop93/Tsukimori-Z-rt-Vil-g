extends Node
var failures: Array[String] = []
func check(ok: bool, message: String) -> void:
	if not ok:
		failures.append(message)
		push_error(message)
func press(code: Key) -> void:
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
	await press(KEY_E)
	await get_tree().create_timer(1.7).timeout
	var vn: CanvasLayer = runner.arrival.vn
	check(vn != null and vn.active,"E starts VN at Miyako")
	if vn == null:
		get_tree().quit(1)
		return
	check(vn.index == 0,"Trigger press did not consume greeting")
	check(vn.portrait.size == Vector2(140,190),"Reference portrait fits its frame")
	await press(KEY_SPACE)
	check(vn.index == 0 and vn.body.visible_characters == vn.body.get_total_character_count(),"First press reveals greeting")
	Input.action_press("walk_right")
	var at: Vector2 = runner.street.player.position
	await get_tree().create_timer(0.3).timeout
	Input.action_release("walk_right")
	check(runner.street.player.position.distance_to(at) < 0.1,"Walking blocked during VN")
	for i in 3:
		if i > 0:
			await press(KEY_ENTER)
			await press(KEY_SPACE)
		check(vn.index == i,"Exactly one page per completed advance")
		await RenderingServer.frame_post_draw
		check(vn.body.get_line_count()*vn.body.get_line_height() <= vn.body.size.y,"Dialogue fits without clipping")
		get_viewport().get_texture().get_image().save_png("res://review/vn_miyako_"+str(i)+".png")
	check(not GameState.has_flag("met_miyako"),"No completion flag before final acknowledgement")
	await press(KEY_E)
	check(GameState.has_flag("met_miyako") and GameState.has_flag("miyako_first_dialogue_seen"),"Completion sets flags")
	check(not vn.active and runner.street.player.input_enabled,"Final acknowledgement returns control")
	await press(KEY_E)
	check(not vn.active,"Completed greeting does not replay")
	var report := {"passed":failures.is_empty(),"failures":failures}
	FileAccess.open("res://review/vn_dialogue_results.json",FileAccess.WRITE).store_string(JSON.stringify(report,"  "))
	print("VN_DIALOGUE: "+JSON.stringify(report))
	get_tree().quit(0 if failures.is_empty() else 1)
