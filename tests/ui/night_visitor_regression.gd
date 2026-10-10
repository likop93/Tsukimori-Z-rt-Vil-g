extends "res://tests/ui/hana_day_regression.gd"

func _ready() -> void:
	var catalog = preload("res://scripts/ui/chapter_catalog.gd")
	check(catalog.prepare("visitor"),"Visitor checkpoint exists")
	check(GameState.horror_pressure == 0,"Checkpoint invents no rejection")
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	await get_tree().process_frame
	var day: Node = runner.arrival.next_day
	check(day.phase == "night_visitor","Checkpoint enters visitor")
	check(not GameState.has_flag("night_visitor_complete"),"No premature completion")
	check(not GameState.has_flag("shion_appointment_expected"),"No premature appointment reveal")
	check(not runner.street.player.visible,"Night remains VN-only")
	await finish(day.vn)
	check(day.phase == "visitor_complete","Full scene terminates")
	for flag in ["black_pool_dream_seen","wet_notebook_seen","night_visitor_glimpsed","shion_name_heard","shion_appointment_expected","night_visitor_complete"]:
		check(GameState.has_flag(flag),"Story event reached: "+flag)
	check(not GameState.has_flag("met_shion"),"A glimpse does not count as a consultation")
	check(GameState.aff_miyako == 0 and GameState.aff_hana == 0,"No invented affinity")
	day.phase = "afternoon_complete"
	day.continue_armed = false
	day.start_night_visitor()
	check(day.phase == "afternoon_complete","Held ending input cannot skip into night")
	day.phase = "visitor_complete"
	GameState.clear_runtime_state()
	check(not GameState.has_flag("night_visitor_complete"),"New game resets night")
	print("NIGHT_VISITOR: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
