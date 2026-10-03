extends Node
var failures: Array[String] = []
func check(ok: bool, message: String) -> void:
	if not ok:
		failures.append(message)
		push_error(message)
func _ready() -> void:
	GameState.clear_runtime_state()
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	var cameo: Node2D = runner.street.kuroe_cameo
	await get_tree().create_timer(0.2).timeout
	check(not cameo.started,"No cameo during intro")
	runner.skip_all()
	await get_tree().process_frame
	check(not cameo.started,"Gate spawn does not auto-trigger cameo")
	runner.street.player.position = Vector2(535,240)
	await get_tree().create_timer(3.0).timeout
	check(cameo.visible and cameo.visual.frame >= 4,"Passing glance appears near player")
	check(runner.street.player.input_enabled and not runner.dialogue.visible,"Cameo never locks input or starts dialogue")
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/kuroe_cameo.png")
	check(cameo.modulate.a == 1.0,"Architecture masks the actor without fading")
	# Capture architectural entry/exit with a frozen actor for visual review.
	var saved_position: Vector2 = cameo.position
	cameo.set_physics_process(false)
	for x in [425.0,625.0]:
		cameo.position.x = x
		await RenderingServer.frame_post_draw
		get_viewport().get_texture().get_image().save_png("res://review/kuroe_occlusion_"+str(int(x))+".png")
	cameo.position = saved_position
	cameo.set_physics_process(true)
	await get_tree().create_timer(4.0).timeout
	check(cameo.done and not cameo.visible and GameState.has_flag("kuroe_cameo_passed"),"Cameo exits and finishes once")
	check(cameo.visited.size() >= 6,"Walk and glance animation frames are used")
	var elapsed: float = cameo.elapsed
	await get_tree().create_timer(0.2).timeout
	check(cameo.elapsed == elapsed,"Cameo cannot replay")
	var interrupted: Node2D = load("res://scripts/opening/kuroe_cameo.gd").new()
	interrupted.street = runner.street
	runner.street.player.get_parent().add_child(interrupted)
	await get_tree().create_timer(0.1).timeout
	check(interrupted.started,"Exit test starts a cameo")
	runner.street.show_location("bridge")
	await get_tree().process_frame
	await get_tree().physics_frame
	await get_tree().process_frame
	check(interrupted.done and not interrupted.visible,"Leaving street cancels cameo before it reaches bridge")
	print("KUROE_CAMEO: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
