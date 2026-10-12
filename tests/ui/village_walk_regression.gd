extends "res://tests/ui/hana_day_regression.gd"

func _ready() -> void:
	preload("res://scripts/ui/chapter_catalog.gd").prepare("tour")
	check(not GameState.has_flag("met_reina") and not GameState.has_flag("first_day_complete"),"Checkpoint does not complete future scenes")
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	await get_tree().process_frame
	var chapter: Node = runner.arrival
	var tour: Node = chapter.village_tour
	var player: CharacterBody2D = runner.street.player
	check(tour.mode == "walk" and player.input_enabled,"Tour checkpoint is playable")
	tour.open_stop("school")
	check(not is_instance_valid(tour.vn),"Cannot interact with distant entrance")
	tour.finish_tour()
	check(not GameState.has_flag("village_tour_complete"),"Cannot finish unvisited village")
	await get_tree().create_timer(0.6).timeout
	var start := player.position
	Input.action_press("walk_left")
	await get_tree().create_timer(0.5).timeout
	Input.action_release("walk_left")
	await get_tree().create_timer(0.25).timeout
	check(player.position.x < start.x-5,"Movement uses real player input: %s -> %s" % [start,player.position])
	var facing: int = player.facing
	await get_tree().create_timer(0.15).timeout
	check(player.facing == facing,"Stopping preserves facing")
	await capture("village_walk_street_REVIEW")
	runner.pause_menu.open_menu()
	var paused_at := player.position
	Input.action_press("walk_right")
	await get_tree().create_timer(0.15).timeout
	check(player.position == paused_at,"Pause freezes traversal")
	Input.action_release("walk_right")
	runner.pause_menu.resume()
	for area in ["street","bridge"]:
		if area == "bridge":
			player.position = Vector2(550,337)
			await get_tree().process_frame
			await key(KEY_E)
			check(tour.area == "bridge" and runner.street.bridge_rail.visible,"Street exit reaches surveyed bridge")
			await capture("village_walk_bridge_REVIEW")
		for stop in tour.STOP_ORDER:
			if tour.PLACES[stop].area != area:
				continue
			player.position = tour.PLACES[stop].at
			player.velocity = Vector2.ZERO
			await get_tree().process_frame
			var entrance := player.position
			await key(KEY_E)
			check(tour.mode == "dialogue" and tour.vn.active,"E opens encounter: "+stop)
			check(not player.visible and not runner.street.foreground.visible,"No world actor or rail over dialogue")
			for resident in runner.street.residents:
				check(not resident.visible,"Ambient women do not overlay VN")
			if stop == "school":
				await capture("village_walk_reina_REVIEW")
			await finish(tour.vn)
			check(tour.visited.has(stop) and tour.mode == "walk","Encounter returns to walking: "+stop)
			check(player.position.distance_to(entrance) < 1,"Return preserves entrance position")
			check(player.input_enabled and player.visible,"Player restored after conversation")
			tour.open_stop(stop)
			check(not is_instance_valid(tour.vn),"Visited encounter cannot replay")
	check(not GameState.has_flag("met_kuroe") and not GameState.has_flag("oto_identity_revealed"),"Teasers preserve later identities")
	# Return route restores the perspective plate, not the house exterior.
	player.position = Vector2(78,191)
	await get_tree().process_frame
	await key(KEY_E)
	check(tour.area == "street" and runner.street.foreground.visible,"Bridge return restores street geometry")
	Input.action_press("observe")
	await get_tree().process_frame
	var held_area: String = tour.area
	await get_tree().process_frame
	check(tour.area == held_area,"Holding interact cannot bounce through exits")
	Input.action_release("observe")
	await get_tree().process_frame
	if tour.area == "street":
		await key(KEY_E)
	player.position = Vector2(551,205)
	await get_tree().process_frame
	await key(KEY_E)
	check(GameState.has_flag("village_tour_complete") and chapter.phase == "day_evening","Home exit resumes canonical evening")
	print("VILLAGE_WALK: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
