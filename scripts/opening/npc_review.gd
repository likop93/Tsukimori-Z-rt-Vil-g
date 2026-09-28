extends Node
# F6-only presentation harness. The normal F5 entry remains the full opening.
func _ready() -> void:
	GameState.set_flag("opening_intro_seen")
	var runner: Node = preload("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	runner.skip_all()
	await get_tree().create_timer(1.0).timeout
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/short_intro_playable_gate.png")
	print("GATE_REVIEW_READY: player control begins in Village Street")
	get_tree().quit()
