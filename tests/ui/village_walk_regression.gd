extends "res://tests/ui/hana_day_regression.gd"
var runner: Node
var tour: Node
var player: CharacterBody2D

func wait_for_arrival() -> void:
	var deadline := Time.get_ticks_msec()+5000
	while (tour.mode == "travel" or not tour.actions_armed) and Time.get_ticks_msec() < deadline:
		await get_tree().process_frame
	check(tour.mode != "travel" and tour.actions_armed,"Destination controls become ready after fade")

func click(button: Button) -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	check(not button.disabled,"Click target enabled: "+str(button.name))
	var at := button.get_global_rect().get_center()
	var move := InputEventMouseMotion.new()
	move.position = at
	get_viewport().push_input(move,true)
	await get_tree().process_frame
	var event := InputEventMouseButton.new()
	event.button_index = MOUSE_BUTTON_LEFT
	event.position = at
	event.pressed = true
	get_viewport().push_input(event,true)
	await get_tree().process_frame
	event.pressed = false
	get_viewport().push_input(event,true)
	await get_tree().process_frame

func destination(id: String) -> void:
	if tour.mode != "map":
		await click(tour.menu.get_node("map"))
	check(tour.mode == "map","Map opens by click")
	await click(tour.map_panel.get_node("destination_"+id))
	check(tour.mode == "travel","Destination click starts transition")
	await wait_for_arrival()
	check(tour.area == id and tour.mode == ("home" if id == "home" else "place"),"Arrives at "+id)
	check(not player.input_enabled and not player.visible,"No walking avatar on arrival")

func setup() -> void:
	preload("res://scripts/ui/chapter_catalog.gd").prepare("tour")
	runner = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	await get_tree().process_frame
	tour = runner.arrival.village_tour
	player = runner.street.player
	await get_tree().process_frame

func _ready() -> void:
	await setup()
	check(tour.mode == "map","First arrival opens destination map")
	check(tour.map_panel.has_node("destination_home"),"Home visible from first arrival")
	await capture("navigation_map_REVIEW")
	await destination("home")
	check(tour.visited.is_empty(),"Can return home before any encounter")
	check(not GameState.has_flag("village_tour_complete"),"Home does not invent completed visits")
	await capture("navigation_home_REVIEW")
	await destination("school")
	check(runner.street.backdrop.texture.resource_path == tour.layout.school.background,"School background preserved")
	var fixed := player.position
	Input.action_press("walk_right")
	Input.action_press("run")
	await get_tree().create_timer(0.3).timeout
	Input.action_release("walk_right")
	Input.action_release("run")
	check(player.position == fixed,"WASD and run cannot move hidden player")
	await capture("navigation_school_REVIEW")
	runner.pause_menu.open_menu()
	runner.pause_menu.show_controls()
	await capture("navigation_controls_REVIEW")
	tour.navigate("home")
	check(tour.area == "school" and tour.mode == "place","Pause blocks navigation")
	runner.pause_menu.resume()
	for id in tour.STOP_ORDER:
		var area: String = tour.STOP_AREAS[id]
		if tour.area != area:
			await destination(area)
		await click(tour.menu.get_node("stop_"+id))
		check(tour.mode == "dialogue" and is_instance_valid(tour.vn),"Clicked encounter opens: "+id)
		if not is_instance_valid(tour.vn):
			continue
		check(not player.visible and not tour.cast.visible,"VN hides world actors")
		if id in ["school","shop","inn"]:
			check(tour.vn.portrait.visible and tour.vn.akira_portrait.visible,"Frameless portraits retained")
			await capture("navigation_vn_"+id+"_REVIEW")
		# UI travel requests are rejected during a reader-controlled scene.
		tour.navigate("home")
		check(tour.mode == "dialogue","Dialogue cannot be interrupted by navigation")
		await finish(tour.vn)
		check(tour.visited.has(id) and tour.mode == "place","Completed encounter returns to place")
		tour.open_stop(id)
		check(not is_instance_valid(tour.vn),"Completed encounter cannot replay")
		if tour.interiors.has(id):
			await click(tour.menu.get_node("stop_"+id))
			check(tour.mode == "interior","Visited building opens interior: "+id)
			check(runner.street.backdrop.texture.resource_path == tour.interiors[id].background,"Interior background retained")
			await finish(tour.vn)
			check(tour.mode == "place","Interior returns to same place")
		else:
			await get_tree().process_frame
			check(tour.menu.get_node("stop_"+id).disabled,"Finished non-interior action clearly disabled")
		if id == "school":
			await destination("home")
			check(tour.visited.size() == 1 and GameState.has_flag("met_reina"),"Returning home preserves partial exploration")
			await destination("square")
	check(tour.visited.size() == 8,"All eight encounters remain accessible")
	check(not GameState.has_flag("met_kuroe") and not GameState.has_flag("met_shion") and not GameState.has_flag("oto_identity_revealed"),"No premature identities")
	await destination("bridge")
	await capture("navigation_bridge_REVIEW")
	await key(KEY_M)
	check(tour.mode == "map","M opens map")
	await key(KEY_M)
	check(tour.mode == "place" and not player.input_enabled,"M closes without enabling avatar")
	# Pause while fading, then resume to a deterministic destination.
	tour.navigate("home")
	runner.pause_menu.open_menu()
	var fade_alpha: float = tour.travel_fade.color.a
	await get_tree().create_timer(0.3).timeout
	check(tour.mode == "travel" and tour.travel_fade.color.a == fade_alpha,"Pause freezes travel transition")
	runner.pause_menu.resume()
	await wait_for_arrival()
	await click(tour.menu.get_node("evening"))
	check(runner.arrival.phase == "day_evening" and GameState.has_flag("village_tour_complete"),"Full exploration returns to evening")
	check(GameState.has_flag("village_tour_returned_home"),"Evening handoff recorded once")
	runner.queue_free()
	await get_tree().process_frame
	# A fresh run can end the afternoon without being forced through eight stops.
	await setup()
	await destination("home")
	await click(tour.menu.get_node("evening"))
	check(runner.arrival.phase == "day_evening","Early home return can continue the story")
	check(not GameState.has_flag("village_tour_complete") and not GameState.has_flag("met_reina") and not GameState.has_flag("met_aoi"),"Early departure does not fabricate encounters")
	await finish(runner.arrival.vn)
	await finish(runner.arrival.vn)
	check(GameState.has_flag("first_day_complete"),"Early return still reaches end of first day")
	check(not player.visible and not player.input_enabled,"Evening does not re-enable stray movement")
	print("VILLAGE_NAVIGATION: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
