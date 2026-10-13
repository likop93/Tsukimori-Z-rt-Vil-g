extends "res://tests/ui/hana_day_regression.gd"
var runner: Node
var tour: Node
var player: CharacterBody2D

func travel(target: String) -> void:
	var from: String = tour.area
	var exit_point := Vector2.ZERO
	for spec in tour.layout[from].exits:
		if spec.target == target:
			exit_point = tour.point(spec.at)
	check(exit_point != Vector2.ZERO,"Connected edge: "+from+" -> "+target)
	player.position = exit_point
	player.velocity = Vector2.ZERO
	await get_tree().process_frame
	await key(KEY_E)
	check(tour.area == target,"E traverses edge: "+from+" -> "+target)
	check(player.input_enabled,"Player enabled on arrival")
	await get_tree().process_frame

func encounter(id: String) -> void:
	player.position = tour.PLACES[id].at
	player.velocity = Vector2.ZERO
	player.facing = 1
	await get_tree().process_frame
	var entrance := player.position
	await key(KEY_E)
	check(tour.mode == "dialogue" and is_instance_valid(tour.vn),"Encounter opens: "+id)
	if not is_instance_valid(tour.vn):
		return
	check(not player.visible and not tour.cast.visible,"World actors hidden behind VN")
	check(not runner.street.foreground.visible,"No foreground covers VN")
	if id in ["school","shop","inn"]:
		check(tour.vn.portrait.visible and tour.vn.akira_portrait.visible,"Frameless partners: "+id)
		check(tour.vn.portrait.flip_h == (id == "inn"),"Partner faces Akira")
		tour.vn.advance()
		await capture("town_vn_"+id+"_REVIEW")
	await finish(tour.vn)
	check(tour.visited.has(id) and tour.mode == "walk","Encounter finishes: "+id)
	check(player.position.distance_to(entrance)<1 and player.facing == 1,"Return preserves feet and facing")
	tour.open_stop(id)
	check(not is_instance_valid(tour.vn),"Completed encounter cannot repeat")
	if tour.interiors.has(id):
		await key(KEY_E)
		check(tour.mode == "interior" and not player.input_enabled and not player.visible,"Interior uses VN staging: "+id)
		check(runner.street.backdrop.texture.resource_path == tour.interiors[id].background,"Dedicated interior plate: "+id)
		tour.vn.advance()
		await capture("town_inside_"+id+"_REVIEW")
		await finish(tour.vn)
		check(tour.mode == "walk" and player.position.distance_to(entrance)<1,"Interior returns to exterior entrance")

func _ready() -> void:
	preload("res://scripts/ui/chapter_catalog.gd").prepare("tour")
	runner = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	await get_tree().process_frame
	tour = runner.arrival.village_tour
	player = runner.street.player
	check(tour.area == "square" and player.input_enabled,"Tour starts at the main square")
	check(tour.cast.get_child_count() == 4,"Four ambient adult women populate square")
	tour.open_stop("school")
	check(not is_instance_valid(tour.vn),"Distant encounters cannot open")
	tour.finish_tour()
	check(not GameState.has_flag("village_tour_complete"),"Cannot skip unfinished tour")
	await get_tree().create_timer(0.6).timeout
	var start := player.position
	Input.action_press("walk_left")
	await get_tree().create_timer(0.5).timeout
	Input.action_release("walk_left")
	await get_tree().create_timer(0.2).timeout
	check(player.position.x < start.x-15,"Actual walking input moves Akira")
	var face: int = player.facing
	await get_tree().create_timer(0.2).timeout
	check(player.facing == face,"Idle keeps last facing")
	var walk_start := player.position
	Input.action_press("walk_right")
	Input.action_press("run")
	await get_tree().create_timer(0.5).timeout
	Input.action_release("walk_right")
	Input.action_release("run")
	check(player.position.x > walk_start.x+40,"Running is faster than walking")
	await capture("town_square_REVIEW")
	await key(KEY_M)
	check(tour.mode == "map" and not player.input_enabled,"Map pauses movement")
	await capture("town_map_REVIEW")
	await key(KEY_M)
	check(tour.mode == "walk" and player.input_enabled,"Map closes back to movement")
	runner.pause_menu.open_menu()
	var frozen := player.position
	Input.action_press("walk_right")
	await get_tree().create_timer(0.15).timeout
	Input.action_release("walk_right")
	check(player.position == frozen,"Pause freezes the village")
	runner.pause_menu.resume()
	for id in ["school","shop","inn","market","craft_lane"]:
		await travel(id)
		check(runner.street.backdrop.texture.resource_path == str(tour.layout[id].background),"Distinct location plate: "+id)
		var bounds: Rect2 = runner.street.tour_bounds
		check(runner.street.constrain_position(Vector2(-500,-500)) == bounds.position,"Stops at scenery: "+id)
		check(runner.street.constrain_position(Vector2(999,999)) == bounds.end,"Stops at foreground edge: "+id)
		await capture("town_"+id+"_REVIEW")
		for stop in tour.layout[id].stops:
			await encounter(stop)
		var at := player.position
		var facing: int = player.facing
		await travel("square")
		var return_point: Vector2 = tour.saved_positions[id]
		await travel(id)
		check(player.position.distance_to(return_point)<1,"Revisit restores exit feet: "+id)
		await travel("square")
	await travel("stream")
	await capture("town_stream_REVIEW")
	await encounter("stream")
	check(not tour.cast.has_node("shion"),"Shion glimpse ends without formal introduction")
	await travel("shrine")
	await capture("town_shrine_REVIEW")
	await encounter("shrine")
	await travel("stream")
	await travel("bridge")
	check(runner.street.bridge_rail.visible,"Bridge has foreground rail")
	for patch in runner.street.bridge_rail.get_children():
		check(patch.texture == runner.street.backdrop.texture,"Bridge rail matches time of day")
	await capture("town_bridge_REVIEW")
	await travel("stream")
	Input.action_press("observe")
	await get_tree().process_frame
	var held_area: String = tour.area
	await get_tree().process_frame
	check(tour.area == held_area,"Held interact cannot bounce")
	Input.action_release("observe")
	await get_tree().process_frame
	if tour.area == "stream":
		await travel("bridge")
	check(tour.visited.size() == 8,"Eight canonical encounters reached")
	check(not GameState.has_flag("met_kuroe") and not GameState.has_flag("met_shion") and not GameState.has_flag("oto_identity_revealed"),"Later identities stay hidden")
	runner.pause_menu.open_menu()
	runner.pause_menu.show_characters()
	var entries: Array = runner.pause_menu.journal_entries
	check(entries.any(func(e): return e.id == "aoi" and e.known),"Aoi journal unlocked")
	var reina_index := -1
	for i in entries.size():
		if entries[i].id == "reina":
			reina_index = i
	check(reina_index >= 0,"Reina journal unlocked")
	runner.pause_menu.show_character(reina_index)
	await capture("town_reina_journal_REVIEW")
	runner.pause_menu.resume()
	player.position = Vector2(551,205)
	await get_tree().process_frame
	await key(KEY_E)
	check(GameState.has_flag("village_tour_complete") and runner.arrival.phase == "day_evening","Home resumes Miyako evening")
	check(not runner.street.tour_bounds.has_area(),"Tour geometry cleared at story handoff")
	runner.street.show_location("street")
	check(runner.street.foreground.texture.resource_path.ends_with("street_clean_source_REVIEW.png"),"Original opening remains intact")
	print("VILLAGE_WALK: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
