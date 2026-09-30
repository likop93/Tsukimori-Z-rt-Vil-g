extends Node
var failures: Array[String] = []
func check(ok: bool, label: String) -> void:
	if not ok:
		failures.append(label)
		push_error(label)
func _ready() -> void:
	GameState.clear_runtime_state()
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	await get_tree().process_frame
	runner.set_process(false)
	var space := InputEventKey.new()
	space.keycode = KEY_SPACE
	space.pressed = true
	# Exercise all shots with repeated actual key-handler calls, including silent beats.
	for index in runner.beats.size():
		runner.set_beat(index)
		runner.beat_time = float(runner.beats[index].duration)*0.4
		runner._process(0.0)
		var time: float = runner.beat_time
		var actor_at: Vector2 = runner.opening_stage.actor.global_position
		var camera_at: Vector2 = runner.shot.position
		var sound_cursor: int = runner.ambience.cue_cursor
		for press in 15:
			runner._unhandled_input(space)
			runner._process(0.0)
		check(runner.beat_index == index and runner.beat_time == time,"Space must not seek "+str(runner.beats[index].id))
		check(runner.opening_stage.actor.global_position.is_equal_approx(actor_at),"Space must not teleport actor")
		check(runner.shot.position.is_equal_approx(camera_at),"Space must not jump camera")
		check(runner.ambience.cue_cursor == sound_cursor,"Space must not replay audio")
	check(not runner.completed,"Space cannot skip the cinematic")
	var shots := [
		[1,15.0,"bus_katsuro"],[2,1.8,"memory_warm"],[2,4.0,"memory_touch"],
		[2,5.8,"memory_cold"],[2,7.5,"memory_wrist"],[2,9.5,"memory_recoil"],
		[3,0.8,"bus_recovery"],[4,1.9,"disembark"],[4,6.0,"bus_departure"],
		[5,7.0,"forest_walk"],[6,3.0,"gate_approach"]
	]
	for spec in shots:
		runner.set_beat(spec[0])
		runner.beat_time = spec[1]
		runner._process(0.0)
		runner.reveal_time = 10
		runner._process(0.0)
		if runner.fade != null:
			runner.fade.kill()
		runner.shot.modulate.a = 1
		if DisplayServer.get_name() != "headless":
			await RenderingServer.frame_post_draw
			get_viewport().get_texture().get_image().save_png("res://review/cinematic_v2_"+str(spec[2])+".png")
	runner.set_beat(5)
	runner.beat_time = 12
	runner.auto_advance = false
	runner._process(0.0)
	var endpoint: Vector2 = runner.opening_stage.actor.global_position
	runner.set_beat(6)
	runner._process(0.0)
	check(runner.opening_stage.actor.global_position.distance_to(endpoint)<0.1,"Forest to gate preserves actor screen position")
	runner.skip_all()
	check(runner.completed and runner.street.player.input_enabled,"Explicit skip still hands control back")
	var report := {"passed":failures.is_empty(),"failures":failures,"suite":"cinematic_input"}
	FileAccess.open("res://review/cinematic_input_results.json",FileAccess.WRITE).store_string(JSON.stringify(report,"  "))
	print("CINEMATIC_INPUT: "+JSON.stringify(report))
	get_tree().quit(0 if failures.is_empty() else 1)
