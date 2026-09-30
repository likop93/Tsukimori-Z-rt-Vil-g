extends Node
var failures: Array[String] = []
func check(ok: bool, label: String) -> void:
	if not ok:
		failures.append(label)
		push_error(label)
func shot(label: String) -> void:
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/grounding_"+label+".png")
func _ready() -> void:
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	await get_tree().process_frame
	runner.skip_all()
	runner.set_process(false)
	for y in [150,215,270,339]:
		var left: Vector2 = runner.street.constrain_position(Vector2(-1000,y))
		var right: Vector2 = runner.street.constrain_position(Vector2(2000,y))
		check(left.x < right.x and left.x > 430 and right.x < 640,"Conservative street limits protect scenery")
		runner.street.player.position = left
		await get_tree().physics_frame
		await shot("street_left_"+str(y))
	runner.street.show_location("house")
	runner.arrival = load("res://scripts/opening/arrival_director.gd").new()
	runner.add_child(runner.arrival)
	runner.arrival.runner = runner
	runner.arrival.done = true
	runner.arrival.show_miyako()
	var miyako: Node = runner.arrival.miyako
	for f in 4:
		miyako.frame = f
		check(absf(miyako.visual.offset.y+miyako.pivots[f].y)<0.01,"Every Miyako pose has the same foot baseline")
	runner.street.player.position = Vector2(300,274)
	Input.action_press("walk_right")
	await get_tree().create_timer(1.5).timeout
	Input.action_release("walk_right")
	check(runner.street.player.position.x < 335,"Player cannot walk through Miyako")
	await shot("miyako_contact")
	for x in [145,242,320,438,530]:
		runner.street.player.position = Vector2(x,280)
		await get_tree().physics_frame
		await shot("house_rail_"+str(x))
	runner.street.show_location("bridge")
	check(not miyako.visible and miyako.body.collision_layer == 0,"Miyako stays in the house scene")
	for x in [190,252,310,367,490]:
		runner.street.player.position = runner.street.constrain_position(Vector2(x,0))
		await get_tree().physics_frame
		await shot("bridge_"+str(x))
	var report := {"passed":failures.is_empty(),"failures":failures}
	FileAccess.open("res://review/grounding_results.json",FileAccess.WRITE).store_string(JSON.stringify(report,"  "))
	print("GROUNDING: "+JSON.stringify(report))
	get_tree().quit(0 if failures.is_empty() else 1)

