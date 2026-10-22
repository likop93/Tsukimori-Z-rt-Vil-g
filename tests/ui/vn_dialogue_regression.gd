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
	preload("res://scripts/ui/chapter_catalog.gd").prepare("miyako")
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	await get_tree().process_frame
	await get_tree().process_frame
	var vn: CanvasLayer = runner.arrival.vn
	check(vn != null and vn.active,"Implemented Miyako checkpoint starts the real greeting")
	if vn == null:
		get_tree().quit(1)
		return
	check(vn.index == 0,"Trigger press did not consume greeting")
	check(vn.portrait.get_parent() == vn.root and vn.akira_portrait.get_parent() == vn.root,"Both characters have no portrait panel")
	check(not runner.heading.visible,"Arrival heading yields space to the conversation")
	check(vn.portrait.position.y >= 24 and vn.akira_portrait.position.y >= 24,"Portraits have headroom")
	check(vn.portrait.position.x > 320 and vn.akira_portrait.position.x < 320,"Arrival preserves Akira-left, Miyako-right screen direction")
	check(not vn.portrait.flip_h and vn.akira_portrait.flip_h,"Original portraits face toward each other")
	check(vn.world_dim.visible and vn.world_dim.color.a > 0.0 and vn.world_dim.color.a < 0.6,"World stays visible behind subdued dialogue backdrop")
	check(runner.street.player.visible and runner.arrival.miyako.visible,"Hybrid dialogue retains both world actors")
	check(vn.akira_portrait.visible and vn.akira_portrait.texture.get_image().get_pixel(0,0).a < 0.01,"Akira portrait has transparent background")
	check(vn.portrait.texture.get_image().get_pixel(0,0).a < 0.01,"Character background is transparent")
	check(vn.portrait_source_path == "res://assets/opening/vn_portraits/v4/miyako_owner_cutout_REVIEW.png","First greeting uses the original V4 M0 cutout, not an invented expression")
	check(vn.akira_portrait.texture.resource_path == "res://assets/opening/vn_portraits/v4/akira_owner_original_REVIEW.png","First greeting uses the original V4 A0 portrait")
	var partner_rect: Rect2 = vn.portrait.get_rect()
	var akira_rect: Rect2 = vn.akira_portrait.get_rect()
	runner.pause_menu.open_menu()
	var paused_index: int = vn.index
	await press(KEY_SPACE)
	check(vn.index == paused_index and not GameState.has_flag("met_miyako"),"Pause does not advance or complete the greeting")
	runner.pause_menu.resume()
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
		check(vn.portrait.get_rect() == partner_rect and vn.akira_portrait.get_rect() == akira_rect,"Character scale and positions stay fixed on every page")
		await RenderingServer.frame_post_draw
		check(vn.body.get_line_count()*vn.body.get_line_height() <= vn.body.size.y,"Dialogue fits without clipping")
		check(vn.body.position.y+vn.body.size.y <= vn.next_button.position.y-4,"Compact text clears the controls")
		get_viewport().get_texture().get_image().save_png("res://review/vn_miyako_"+str(i)+".png")
	check(not GameState.has_flag("met_miyako"),"No completion flag before final acknowledgement")
	await press(KEY_E)
	check(GameState.has_flag("met_miyako") and GameState.has_flag("miyako_first_dialogue_seen"),"Completion sets flags")
	check(not vn.active and runner.street.player.input_enabled,"Final acknowledgement returns control")
	check(not vn.root.visible and runner.heading.visible,"Closing dialogue restores undimmed exploration and heading")
	check(runner.arrival.done,"Completed greeting remains done until explicit house entry")
	check(not GameState.has_flag("miyako_transformation_revealed") and GameState.character_stage("miyako") == 0,"Greeting leaves early Miyako unchanged")
	# Reusing the shared presenter must not spread the arrival layout to other scenes.
	vn.begin(JSON.parse_string(FileAccess.get_file_as_string("res://data/opening/miyako_interior_dialogue.json")))
	check(not vn.world_dim.visible and vn.dialogue_panel.position.y == 232,"Default interior presentation is retained")
	check(vn.akira_portrait.size == Vector2(228,312) and vn.portrait.position.x < 320,"Interior restores its portrait scale and screen direction")
	await RenderingServer.frame_post_draw
	var report := {"passed":failures.is_empty(),"failures":failures}
	FileAccess.open("res://review/vn_dialogue_results.json",FileAccess.WRITE).store_string(JSON.stringify(report,"  "))
	print("VN_DIALOGUE: "+JSON.stringify(report))
	runner.queue_free()
	await get_tree().process_frame
	await get_tree().process_frame
	get_tree().quit(0 if failures.is_empty() else 1)
