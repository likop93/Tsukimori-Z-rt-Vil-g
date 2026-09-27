extends Node
# F6-only presentation harness. The normal F5 entry remains the full opening.
func _ready() -> void:
	GameState.set_flag("opening_intro_seen")
	var runner: Node = preload("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	runner.request_skip()
	runner.street.player.position = Vector2(435,367)
	runner.street.camera_x = 435
	runner.street.camera.position.x = 435
	await get_tree().create_timer(1.0).timeout
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/staging_v3_integrated.png")
	print("STAGING_V3_READY: revised street scale, Akira directional gait, approved residents")
