extends Node
var failures: Array[String] = []
func _ready() -> void:
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	await get_tree().process_frame
	runner.set_process(false)
	for index in [5,6]:
		runner.set_beat(index)
		runner.beat_time = 10 if index == 5 else 3
		runner._process(0.0)
		runner.reveal_time = 10
		runner._process(0.0)
		await RenderingServer.frame_post_draw
		get_viewport().get_texture().get_image().save_png("res://review/subtitle_layer_"+str(index)+".png")
		# A solid test panel must cover foliage at every lower-edge pixel.
		# Visibility/alpha assertions alone cannot detect a higher-Z occluder.
		var original: StyleBoxFlat = runner.dialogue.get_theme_stylebox("panel")
		var solid: StyleBoxFlat = original.duplicate()
		solid.bg_color = Color(0.9,0.05,0.7,1)
		runner.dialogue.add_theme_stylebox_override("panel",solid)
		await RenderingServer.frame_post_draw
		var capture := get_viewport().get_texture().get_image()
		for point in [Vector2i(48,337),Vector2i(320,337),Vector2i(590,337)]:
			var c := capture.get_pixelv(point)
			if c.r < 0.8 or c.g > 0.15 or c.b < 0.6:
				failures.append("Foreground overwrites subtitle at "+str(point)+" in beat "+str(index))
		runner.dialogue.add_theme_stylebox_override("panel",original)
	var report := {"passed":failures.is_empty(),"failures":failures}
	FileAccess.open("res://review/subtitle_layer_results.json",FileAccess.WRITE).store_string(JSON.stringify(report,"  "))
	print("SUBTITLE_LAYER: "+JSON.stringify(report))
	get_tree().quit(0 if failures.is_empty() else 1)
