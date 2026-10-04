extends Node
var failures: Array[String] = []

func check(ok: bool, message: String) -> void:
	if not ok:
		failures.append(message)
		push_error(message)

func key(code: Key) -> void:
	var event := InputEventKey.new()
	event.keycode = code
	event.pressed = true
	Input.parse_input_event(event)
	await get_tree().process_frame
	event = InputEventKey.new()
	event.keycode = code
	event.pressed = false
	Input.parse_input_event(event)
	await get_tree().process_frame

func capture(name: String) -> void:
	if DisplayServer.get_name() != "headless":
		await RenderingServer.frame_post_draw
		get_viewport().get_texture().get_image().save_png("res://review/menu_"+name+".png")

func _ready() -> void:
	await get_tree().process_frame
	# Keep this test alive when the menu replaces the current scene.
	var menu: Control = load("res://scenes/ui/main_menu.tscn").instantiate()
	get_tree().root.add_child(menu)
	get_tree().current_scene = menu
	await get_tree().process_frame
	check(get_viewport().gui_get_focus_owner() == menu.start_button,"Start initially focused")
	check(not menu.starting,"No automatic cinematic start")
	await capture("main")
	await key(KEY_DOWN)
	check(get_viewport().gui_get_focus_owner() == menu.chapters_button,"Down selects chapter selector")
	await key(KEY_DOWN)
	check(get_viewport().gui_get_focus_owner() == menu.settings_button,"Down selects settings")
	await key(KEY_ENTER)
	check(is_instance_valid(menu.modal) and menu.settings_open,"Enter opens settings")
	if not is_instance_valid(menu.modal):
		get_tree().quit(1)
		return
	var original_volume: float = AppSettings.volume
	var original_fullscreen: bool = AppSettings.fullscreen
	menu.slider.value = 0
	check(AudioServer.is_bus_mute(0),"Zero volume mutes audio")
	menu.slider.value = 65
	check(not AudioServer.is_bus_mute(0) and is_equal_approx(AppSettings.volume,0.65),"Slider updates volume")
	menu.fullscreen.button_pressed = not original_fullscreen
	check(AppSettings.fullscreen != original_fullscreen,"Fullscreen toggle applies preference")
	menu.fullscreen.button_pressed = original_fullscreen
	await capture("settings")
	await key(KEY_ESCAPE)
	check(not is_instance_valid(menu.modal),"Escape closes settings")
	check(get_viewport().gui_get_focus_owner() == menu.settings_button,"Focus restored after settings")
	var config := ConfigFile.new()
	check(config.load(AppSettings.CONFIG_PATH) == OK,"Preferences saved")
	check(is_equal_approx(float(config.get_value("audio","volume",-1)),0.65),"Saved volume matches selection")
	AppSettings.set_volume(0.1)
	AppSettings._ready()
	check(is_equal_approx(AppSettings.volume,0.65),"Preferences reload correctly")
	AppSettings.set_volume(original_volume)
	AppSettings.set_fullscreen(original_fullscreen)
	AppSettings.save_settings()
	await key(KEY_DOWN)
	await key(KEY_ENTER)
	check(is_instance_valid(menu.modal) and not menu.settings_open,"Keyboard opens controls")
	await capture("controls")
	await key(KEY_ESCAPE)
	GameState.set_flag("opening_intro_seen")
	GameState.set_flag("entered_tsukimori")
	GameState.story_phase = 9
	menu.start_button.grab_focus()
	await key(KEY_ENTER)
	check(menu.starting,"Enter starts transition")
	menu.start_game()
	await get_tree().create_timer(0.8).timeout
	var runner := get_tree().current_scene
	check(runner.scene_file_path == "res://scenes/opening/opening.tscn","Menu enters opening scene")
	check(GameState.flags.is_empty() and GameState.story_phase == 0,"New game clears runtime state")
	check(not runner.completed and not runner.street.player.input_enabled,"Opening starts with control locked")
	runner.skip_all()
	check(GameState.has_flag("opening_intro_seen") and GameState.has_flag("entered_tsukimori"),"Skip sets both required flags")
	check(runner.street.player.input_enabled,"Skip hands control to player")
	var report := {"passed":failures.is_empty(),"failures":failures,"suite":"main_menu"}
	FileAccess.open("res://review/main_menu_results.json",FileAccess.WRITE).store_string(JSON.stringify(report,"  "))
	print("MAIN_MENU: "+JSON.stringify(report))
	get_tree().quit(0 if failures.is_empty() else 1)
