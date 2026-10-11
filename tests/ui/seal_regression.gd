extends "res://tests/ui/hana_day_regression.gd"

func _ready() -> void:
	preload("res://scripts/ui/chapter_catalog.gd").prepare("shion")
	GameState.record_distance("second_morning","withdraw")
	GameState.record_distance("miyako_afternoon","keep_distance")
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	await get_tree().process_frame
	var day: Node = runner.arrival.next_day
	await finish(day.vn,"wait_melody")
	await finish(day.vn,"ask_consent")
	await finish(day.vn)
	day.start_seal()
	check(day.phase == "shion_complete","Held ending input cannot start seal")
	day.advance(0.0)
	day.continue_button.pressed.emit()
	await get_tree().process_frame
	check(day.phase == "miyako_seal","Shion ending continues to Miyako")
	check(not GameState.has_flag("akira_right_eye_green"),"Eye change is not premature")
	check(day.vn.portrait_source_path.ends_with("miyako_transformed_manic_v1_REVIEW.png"),"Miyako transformation persists")
	var before_aff: int = GameState.aff_miyako
	await finish(day.vn)
	check(day.phase == "seal_complete","Seal scene finishes")
	for flag in ["akira_seal_revealed","invitation_authorship_questioned","katsuro_voice_shared","tape_awakened","seal_fan_vision_seen","akira_right_eye_green","seal_stone_split","miyako_seal_complete"]:
		check(GameState.has_flag(flag),"Reached event: "+flag)
	check(day.vn.akira_portrait.texture.resource_path.ends_with("akira_doctor_green_eye_v1_REVIEW.png"),"Eye change has matching art")
	check(GameState.aff_miyako == before_aff,"No invented affinity")
	var entry: Dictionary = preload("res://scripts/ui/character_journal.gd").entries()[0]
	check(entry.portrait.ends_with("akira_doctor_green_eye_v1_REVIEW.png"),"Journal tracks eye change")
	day.continue_armed = false
	Input.action_press("observe")
	day.advance(0.0)
	day.start_tea()
	check(day.phase == "seal_complete","Held ending input cannot start tea")
	Input.action_release("observe")
	day.advance(0.0)
	day.continue_button.pressed.emit()
	await get_tree().process_frame
	check(day.phase == "miyako_tea" and day.vn.index == 0,"Seal continues to tea without losing first line")
	GameState.clear_runtime_state()
	check(not GameState.has_flag("miyako_seal_complete"),"Reset clears seal progress")
	print("SEAL: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
