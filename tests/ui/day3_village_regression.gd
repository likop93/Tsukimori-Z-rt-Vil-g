extends "res://tests/ui/village_walk_regression.gd"

func _ready() -> void:
	for choice in ["ask_work","browse"]:
		preload("res://scripts/ui/chapter_catalog.gd").prepare("shion")
		if choice == "browse":
			GameState.set_flag("shop_discovered")
			GameState.set_flag("met_aoi")
		runner = load("res://scenes/opening/opening.tscn").instantiate()
		add_child(runner)
		await get_tree().process_frame
		var day: Node = runner.arrival.next_day
		await finish(day.vn,"wait_melody")
		await finish(day.vn,"ask_consent")
		await finish(day.vn)
		day.advance(0)
		await click(day.continue_button)
		await finish(day.vn)
		check(day.phase == "seal_complete","Existing Shion and seal remain connected")
		day.advance(0)
		await click(day.continue_button)
		tour = day.afternoon_walk
		player = runner.street.player
		check(tour.mode == "map" and GameState.day == 3,"Day three opens existing map")
		var before: Array = [GameState.aff_shion,GameState.aff_hana,GameState.aff_miyako,GameState.horror_pressure]
		await destination("shop")
		if choice == "ask_work":
			check(tour.menu.get_node("ayame").disabled,"Aoi remains the shop introduction")
			await click(tour.menu.get_node("stop_shop"))
			check(tour.vn.akira_portrait.texture.resource_path.ends_with("akira_doctor_green_eye_v1_REVIEW.png"),"Later first meetings retain Akira's changed eye")
			await finish(tour.vn)
		await get_tree().process_frame
		check(GameState.has_flag("met_aoi") and not GameState.has_flag("met_ayame"),"Aoi and Ayame are separate")
		await click(tour.menu.get_node("ayame"))
		check(tour.vn.active and tour.vn.index == 0,"Click does not skip Ayame's first line")
		check(runner.street.backdrop.texture is AtlasTexture,"Original source uses a runtime frame")
		check(runner.street.backdrop.texture.region.end.y == 650,"Baked UI excluded from artwork")
		runner.pause_menu.open_menu()
		var index: int = tour.vn.index
		await get_tree().process_frame
		tour.navigate("home")
		check(tour.mode == "dialogue" and tour.vn.index == index,"Pause and dialogue block travel")
		runner.pause_menu.resume()
		tour.vn.revealed = tour.vn.body.get_total_character_count()
		tour.vn.body.visible_characters = tour.vn.body.get_total_character_count()
		await capture("day3_ayame_REVIEW")
		await finish(tour.vn,choice)
		check(GameState.has_flag("met_ayame") and GameState.completed_events.has("day3_ayame_first_meeting"),"Meeting completes after its final acknowledgement")
		check(GameState.completed_events.get("day3_ayame_first_meeting",{}).get("choice","") == choice,"The acknowledged choice is retained without invented points")
		var count: int = GameState.completed_events.size()
		tour.open_day3_event("ayame")
		check(tour.mode == "place" and GameState.completed_events.size() == count,"First meeting cannot replay")
		await destination("market")
		await click(tour.menu.get_node("stop_market"))
		check(not GameState.has_flag("himiko_arrival_mentioned"),"Himiko mention waits for acknowledgement")
		await finish(tour.vn)
		check(GameState.has_flag("himiko_arrival_mentioned") and not GameState.has_flag("met_himiko"),"Preparation is not a physical meeting")
		await destination("home")
		await click(tour.menu.get_node("evening"))
		check(day.phase == "miyako_tea" and day.vn.index == 0,"Home continues directly to preserved tea")
		check(GameState.day == 3 and GameState.time_of_day == "evening","Calendar never rewinds")
		check(before == [GameState.aff_shion,GameState.aff_hana,GameState.aff_miyako,GameState.horror_pressure],"Ordinary meetings add no relationship or horror points")
		check(not GameState.has_flag("weather_anomaly") and not GameState.has_flag("miyako_transformation_revealed"),"Early-day canon guards remain false")
		check(GameState.commitments.is_empty(),"No automatic romantic commitment")
		await finish(day.vn,"friends")
		check(day.phase == "tea_complete","Third-day chain reaches its existing ending")
		runner.queue_free()
		await get_tree().process_frame
	GameState.clear_runtime_state()
	check(not GameState.has_flag("met_ayame") and GameState.completed_events.is_empty(),"New game clears meetings")
	print("DAY3_VILLAGE: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
