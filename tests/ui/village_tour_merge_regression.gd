extends "res://tests/ui/hana_day_regression.gd"

func _ready() -> void:
	preload("res://scripts/ui/chapter_catalog.gd").prepare("clinic")
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	await get_tree().process_frame
	var chapter: Node = runner.arrival
	chapter.vn.queue_free()
	chapter.start_village_tour()
	var tour: Node = chapter.village_tour
	tour.finish_tour()
	check(not GameState.has_flag("village_tour_complete"),"Tour must return home before ending afternoon")
	for stop in tour.STOP_ORDER:
		await tour.navigate(tour.STOP_AREAS[stop])
		tour.open_stop(stop)
		await finish(tour.vn)
		check(tour.visited.has(stop),"Tour stop completes: "+stop)
	check(GameState.has_flag("met_reina") and not GameState.has_flag("met_kuroe"),"Tour reveals Reina but not Kuroe")
	check(not GameState.has_flag("oto_identity_revealed"),"Oto identity remains hidden")
	await tour.navigate("home")
	tour.finish_tour()
	await get_tree().process_frame
	check(GameState.has_flag("village_tour_complete") and chapter.phase == "day_evening","Remote tour reconnects to existing evening")
	for id in ["miyako","hana","kuroe","shion","reina"]:
		GameState.set_flag("met_"+id)
	runner.pause_menu.open_menu()
	runner.pause_menu.show_characters()
	check(runner.pause_menu.journal_entries.size() >= 7,"Known character sheets coexist with village residents")
	runner.pause_menu.show_character(5)
	await get_tree().process_frame
	var list_button: Control = get_viewport().gui_get_focus_owner()
	var list_scroll: ScrollContainer = list_button.get_parent().get_parent()
	check(list_scroll.get_global_rect().end.y < runner.pause_menu.panel.global_position.y+280,"Character list clears return button")
	await capture("six_character_journal_REVIEW")
	runner.pause_menu.resume()
	print("VILLAGE_TOUR_MERGE: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
