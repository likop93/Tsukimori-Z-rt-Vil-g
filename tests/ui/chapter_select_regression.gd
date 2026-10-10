extends Node
var failures: Array[String] = []
const Catalog := preload("res://scripts/ui/chapter_catalog.gd")

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
	get_viewport().get_texture().get_image().save_png("res://review/chapter_"+name+"_REVIEW.png")

func _ready() -> void:
	await get_tree().process_frame
	var entries := Catalog.entries()
	for i in entries.size():
		GameState.clear_runtime_state()
		GameState.set_flag("stale_test_flag")
		GameState.aff_hana = 99
		GameState.hana_first_choice = "ask_body"
		var menu: Control = load("res://scenes/ui/main_menu.tscn").instantiate()
		get_tree().root.add_child(menu)
		get_tree().current_scene = menu
		await get_tree().process_frame
		menu.chapters_button.grab_focus()
		await key(KEY_ENTER)
		check(is_instance_valid(menu.modal) and menu.chapter_buttons.size() == 7,"Selector exposes implemented checkpoints")
		check(get_viewport().gui_get_focus_owner() == menu.chapter_buttons[0],"First chapter receives keyboard focus")
		check(GameState.aff_hana == 99 and GameState.has_flag("stale_test_flag"),"Opening selector does not mutate current session")
		for button in menu.chapter_buttons:
			check(button.position.y+button.size.y < menu.back_button.position.y,"Chapter choices clear back button")
		await key(KEY_ESCAPE)
		check(not is_instance_valid(menu.modal) and get_viewport().gui_get_focus_owner() == menu.chapters_button,"Cancel restores focus without starting")
		await key(KEY_ENTER)
		for down in i:
			await key(KEY_DOWN)
		check(get_viewport().gui_get_focus_owner() == menu.chapter_buttons[i],"Arrow navigation selects requested chapter")
		if i == 0:
			await capture("selector")
		await key(KEY_ENTER)
		check(menu.starting,"Enter starts requested chapter")
		menu.launch_chapter("intro") # Double activation cannot replace the selection.
		await get_tree().create_timer(0.6).timeout
		var runner := get_tree().current_scene
		check(runner.scene_file_path == "res://scenes/opening/opening.tscn","Checkpoint uses the real game scene")
		check(GameState.chapter_start.is_empty(),"Launch request is consumed once")
		check(not GameState.has_flag("stale_test_flag") and GameState.aff_hana == 0 and GameState.hana_first_choice.is_empty(),"Selection clears old progress and scores")
		var id: String = entries[i].id
		if id == "intro":
			check(not runner.completed and GameState.flags.is_empty(),"Intro starts from clean pre-control state")
		else:
			check(runner.completed and runner.handoff_count == 1 and GameState.has_flag("entered_tsukimori"),"Skipped intro hands off exactly once")
		match id:
			"village":
				check(runner.street.location == "street" and runner.street.player.input_enabled,"Village entry is playable at the gate")
				check(not GameState.has_flag("met_miyako"),"Village entry does not reveal Miyako")
			"miyako":
				check(runner.arrival.vn.active and runner.arrival.vn.index == 0,"Miyako starts at greeting without consuming first line")
				check(not GameState.has_flag("met_miyako"),"Greeting still requires acknowledgement")
			"night":
				check(runner.arrival.phase == "room_arrival" and not runner.street.player.visible,"Night starts in VN room")
				check(GameState.has_flag("met_miyako") and not GameState.has_flag("first_night_seen"),"Night has prior meeting but no premature ending")
			"clinic":
				check(runner.arrival.phase == "morning" and runner.arrival.vn.active,"First clinic day starts with original morning choices")
				check(GameState.has_flag("first_night_seen") and not GameState.has_flag("first_clinic_day_seen"),"Clinic entry preserves night and pending consultations")
			"hana":
				check(runner.arrival.next_day.phase == "night_notebook","Hana chapter starts with original notebook lead-in")
				check(GameState.has_flag("first_day_complete") and not GameState.has_flag("met_hana"),"Hana chapter has prior day but no invented meeting")
				check(GameState.miyako_morning_choice == "withdraw" and GameState.clinic_first_choice == "clinical","Skipped choices use canonical zero-point defaults")
				check(GameState.aff_miyako == 0 and GameState.akira_gyogyulas == 0,"Skipped choices grant no affinity or healing")
		if id == "visitor":
			check(runner.arrival.next_day.phase == "night_visitor","Visitor starts at the new night scene")
		if id in ["miyako","night","clinic","hana","visitor"]:
			runner.pause_menu.open_menu()
			check(get_tree().paused,"Pause works after direct chapter entry")
			runner.pause_menu.resume()
			await capture(id)
		GameState.set_flag("invalid_entry_guard")
		check(not Catalog.prepare("unimplemented") and GameState.has_flag("invalid_entry_guard"),"Unknown chapter cannot erase current progress")
		runner.queue_free()
		get_tree().current_scene = null
		await get_tree().process_frame
	Catalog.prepare("intro")
	check(GameState.flags.is_empty() and GameState.hana_first_choice.is_empty(),"New game clears all checkpoint history")
	GameState.chapter_start = ""
	print("CHAPTER_SELECT: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
