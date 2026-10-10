extends "res://tests/ui/hana_day_regression.gd"

func _ready() -> void:
	GameState.clear_runtime_state()
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	runner.skip_all()
	var chapter: Node = load("res://scripts/opening/first_night_director.gd").new()
	runner.add_child(chapter)
	chapter.runner = runner
	chapter.build_presentation()
	check(chapter.photo_back.get_child(0) is TextureRect,"Photo placeholder replaced with actual image")
	chapter.begin_hana_day()
	var day: Node = chapter.next_day
	day.vn.active = false
	day.vn.root.hide()
	day.phase = "hana_close"
	day.finish_dialogue()
	day.start_afternoon()
	check(day.phase == "hana_complete","Ending input cannot skip the transition card")
	day.advance(0.0)
	day.continue_button.pressed.emit()
	await get_tree().process_frame
	check(day.phase == "miyako_afternoon","Continue button starts afternoon")
	check(not GameState.has_flag("akira_wrist_mark_seen"),"Wrist clue not revealed before its line")
	check(day.vn.portrait.flip_h and not day.vn.akira_portrait.flip_h,"Miyako and Akira face inward")
	check(not runner.street.player.visible,"Clinic stays VN-only")
	await capture("miyako_afternoon_REVIEW")
	await finish(day.vn,"accept_concern")
	check(day.phase == "afternoon_complete","Full afternoon ends on its own card")
	check(GameState.has_flag("miyako_hana_afternoon_seen") and GameState.has_flag("akira_wrist_mark_seen") and GameState.has_flag("katsuro_notebook_awakening_seen"),"Story flags committed at their events")
	check(GameState.aff_hana == 0 and GameState.aff_miyako == 0,"Linear scene awards no invented relationship points")
	day.advance(0.0)
	day.continue_button.pressed.emit()
	await get_tree().process_frame
	check(day.phase == "night_visitor","Afternoon continues into night visitor")
	GameState.clear_runtime_state()
	check(not GameState.has_flag("akira_wrist_mark_seen"),"New game clears afternoon flags")
	print("AFTERNOON: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
