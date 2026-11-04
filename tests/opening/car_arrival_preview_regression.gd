extends Node
var failures: Array[String] = []
func check(condition: bool, detail: String) -> void:
	if not condition:
		failures.append(detail)
		push_error(detail)

func _ready() -> void:
	get_window().unfocusable = true
	var tree := get_tree()
	var previous_scale := get_window().content_scale_mode
	GameState.set_flag("review_state_sentinel")
	var before: Dictionary = GameState.flags.duplicate(true)
	var menu: Node = preload("res://scenes/ui/main_menu.tscn").instantiate()
	tree.root.add_child.call_deferred(menu)
	await tree.process_frame
	tree.current_scene = menu
	menu.open_chapters()
	var button: Button
	for child in menu.modal.get_children():
		if child is Button and child.text == "Autós nyitány · próba":
			button = child
	check(is_instance_valid(button),"Preview is reachable from chapter selector")
	if not button:
		tree.quit(1)
		return
	button.pressed.emit()
	await tree.scene_changed
	var preview := tree.current_scene
	check(preview.scene_file_path.ends_with("car_arrival_preview.tscn"),"Menu opens isolated scene")
	preview.get_node("Pause").pressed.emit()
	var stopped: float = preview.time
	await tree.create_timer(0.2,true).timeout
	check(tree.paused and preview.time == stopped,"Pause freezes the timeline")
	preview.get_node("Pause").pressed.emit()
	var marks := [2.0,12.3,17.3]
	Engine.time_scale = 2.0
	for index in marks.size():
		while preview.time < marks[index] and not preview.finished:
			await tree.process_frame
		check(preview.shot == index,"Shot order at capture "+str(index))
		var still: TextureRect = preview.get_node("Still")
		check(still.visible and still.texture.resource_path.get_file().begins_with(["01_", "02_", "03_"][index]),"Original artwork in intended shot")
		check(still.texture.get_size() == Vector2(1672,941) and get_window().content_scale_mode == Window.CONTENT_SCALE_MODE_CANVAS_ITEMS,"Full source and window-resolution CG render")
		if index == 1:
			check(not preview.ambience.vehicle.playing and not preview.get_node("Subtitle").visible,"Motor has stopped during the quiet parking beat")
		if DisplayServer.get_name() != "headless":
			await RenderingServer.frame_post_draw
			get_viewport().get_texture().get_image().save_png("res://review/car_arrival_cg_%d.png" % index)
	while not preview.finished:
		await tree.process_frame
	Engine.time_scale = 1.0
	check(preview.get_node("Replay").visible and not preview.ambience.rain.playing,"Preview ends and offers replay")
	preview.get_node("Replay").pressed.emit()
	await tree.scene_changed
	preview = tree.current_scene
	check(preview.time < 1 and not preview.finished,"Replay begins from road shot")
	preview.get_node("Pause").pressed.emit()
	preview.get_node("Back").pressed.emit()
	await tree.scene_changed
	check(not tree.paused and tree.current_scene.scene_file_path.ends_with("main_menu.tscn"),"Leaving while paused restores the menu")
	check(get_window().content_scale_mode == previous_scale,"Restore menu viewport")
	check(GameState.flags == before,"Preview and replay preserve story flags")
	tree.current_scene.queue_free()
	# Let the audio mixer release the stopped WAV playbacks before exiting the test.
	await tree.create_timer(0.5).timeout
	print("CAR_ARRIVAL_REVIEW: ", JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	tree.quit(0 if failures.is_empty() else 1)
