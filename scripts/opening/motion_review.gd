extends Node
func _ready() -> void:
	var runner: Node = preload("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	runner.skip_all()
	runner.set_process(false)
	runner.street.show_location("bridge")
	runner.street.player.position = Vector2(225,182)
	runner.hint.hide()
	runner.heading.hide()
	DirAccess.make_dir_recursive_absolute("res://review/motion_frames")
	Input.action_press("walk_right")
	for i in 48:
		await get_tree().create_timer(1.0/24.0).timeout
		await RenderingServer.frame_post_draw
		get_viewport().get_texture().get_image().save_png("res://review/motion_frames/%03d.png" % i)
	Input.action_release("walk_right")
	runner.queue_free()
	await get_tree().process_frame
	get_tree().quit()
