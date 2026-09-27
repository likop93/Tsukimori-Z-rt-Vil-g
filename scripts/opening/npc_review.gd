extends Node
# F6-only presentation harness. The normal F5 entry remains the full opening.
func _ready() -> void:
	GameState.set_flag("opening_intro_seen")
	var runner: Node = preload("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	runner.skip_all()
	await get_tree().create_timer(1.0).timeout
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/miyako_arrival_REVIEW.png")
	print("VILLAGE_TARGET_V4_READY: overhead lane, owner image composition and depth scale")
	get_tree().quit()
