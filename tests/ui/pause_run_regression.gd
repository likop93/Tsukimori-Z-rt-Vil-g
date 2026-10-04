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
func capture(name: String) -> void:
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/"+name+".png")
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	GameState.clear_runtime_state()
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	runner.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(runner)
	var menu: CanvasLayer = runner.pause_menu
	var actor: CharacterBody2D = runner.street.player
	await key(KEY_TAB)
	var intro_time: float = runner.beat_time
	await get_tree().create_timer(0.2).timeout
	check(get_tree().paused and runner.beat_time == intro_time,"Menu freezes intro clock")
	await key(KEY_TAB)
	check(not get_tree().paused,"Tab resumes intro")
	Input.action_press("run")
	Input.action_press("walk_right")
	var locked_at: Vector2 = actor.position
	await get_tree().create_timer(0.2).timeout
	check(not actor.running and actor.position == locked_at,"Shift cannot move actor during intro")
	Input.action_release("run")
	Input.action_release("walk_right")
	runner.skip_all()
	runner.street.show_location("bridge")
	var distances: Array[float] = []
	for run in [false,true]:
		actor.position = Vector2(85,190)
		actor.velocity = Vector2.ZERO
		if run:
			Input.action_press("run")
		Input.action_press("walk_right")
		await get_tree().create_timer(0.7).timeout
		distances.append(actor.position.x-85)
		if run:
			check(actor.visual.texture == actor.RUN_ATLAS,"Side run uses separate atlas")
			await capture("akira_run_REVIEW")
		Input.action_release("run")
		Input.action_release("walk_right")
		await get_tree().create_timer(0.3).timeout
	check(distances[1] > distances[0]*1.5,"Run is measurably faster than walk")
	check(actor.velocity.length() < 0.1 and not actor.running,"Releasing input brakes to idle")
	await key(KEY_ESCAPE)
	check(menu.root.visible and get_tree().paused,"Escape opens pause after intro")
	var at: Vector2 = actor.position
	Input.action_press("walk_right")
	Input.action_press("run")
	await get_tree().create_timer(0.2).timeout
	check(actor.position == at,"Movement is frozen during pause")
	Input.action_release("walk_right")
	Input.action_release("run")
	await capture("pause_menu_REVIEW")
	menu.show_settings()
	var volume: float = AppSettings.volume
	menu.slider.value = 65
	check(is_equal_approx(AppSettings.volume,0.65),"Pause settings apply volume")
	await capture("pause_settings_REVIEW")
	await key(KEY_ESCAPE)
	check(menu.page == "main" and get_tree().paused,"Escape returns from settings without resuming")
	AppSettings.set_volume(volume)
	AppSettings.save_settings()
	await key(KEY_ESCAPE)
	check(not get_tree().paused,"Escape resumes gameplay")
	var vn: CanvasLayer = load("res://scripts/ui/vn_dialogue.gd").new()
	runner.add_child(vn)
	vn.begin({"lines":[{"speaker":"Miyako","text":"Dr. Akira. Már vártam."},{"speaker":"Akira","text":"Köszönöm."}]})
	actor.input_enabled = false
	await key(KEY_ESCAPE)
	var revealed: float = vn.revealed
	await key(KEY_SPACE)
	await get_tree().create_timer(0.2).timeout
	check(vn.index == 0 and vn.revealed == revealed,"Pause prevents dialogue reveal and advancement")
	menu.resume()
	Input.action_press("run")
	Input.action_press("walk_right")
	await get_tree().create_timer(0.2).timeout
	check(not actor.running and actor.position == at,"Running stays blocked during dialogue")
	Input.action_release("run")
	Input.action_release("walk_right")
	vn.queue_free()
	actor.input_enabled = true
	runner.street.show_location("house")
	actor.position = Vector2(530,275)
	Input.action_press("walk_right")
	Input.action_press("run")
	await get_tree().create_timer(0.6).timeout
	Input.action_release("walk_right")
	Input.action_release("run")
	check(actor.position.x <= 545 and actor.position.y >= 264 and actor.position.y <= 282,"Run respects house bounds")
	remove_child(runner)
	get_tree().root.add_child(runner)
	get_tree().current_scene = runner
	menu.open_menu()
	menu.return_to_main()
	await get_tree().process_frame
	await get_tree().process_frame
	check(not get_tree().paused and get_tree().current_scene.scene_file_path == "res://scenes/ui/main_menu.tscn","Main menu return clears pause")
	print("PAUSE_RUN: "+JSON.stringify({"passed":failures.is_empty(),"distances":distances,"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
