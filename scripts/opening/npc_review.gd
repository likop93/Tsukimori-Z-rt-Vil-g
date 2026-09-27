extends Node
# F6-only presentation harness. The normal F5 entry remains the full opening.
func _ready() -> void:
	GameState.set_flag("opening_intro_seen")
	var runner: Node = preload("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	runner.request_skip()
	runner.street.player.position = Vector2(365,319)
	runner.street.camera_x = 380
	runner.street.camera.position.x = 380
	await get_tree().create_timer(1.0).timeout
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/until_then_proportions_REVIEW.png")
	print("PROPORTIONS_REVIEW_READY: closer street camera, adult scale and eased gait")
