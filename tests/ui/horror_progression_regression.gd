extends Node
var failures: Array[String] = []

func check(ok: bool, message: String) -> void:
	if not ok:
		failures.append(message)
		push_error(message)

func choose(path: String, id: String) -> void:
	var data: Dictionary = JSON.parse_string(FileAccess.get_file_as_string(path))
	var vn := preload("res://scripts/ui/vn_dialogue.gd").new()
	add_child(vn)
	vn.begin(data)
	vn.show_choices()
	var option: Dictionary = data.choices.filter(func(item): return item.id == id)[0]
	var original_count: int = option.lines.size()
	vn.select_choice(option)
	check(option.lines.size() == original_count,"Source branch untouched")
	if GameState.horror_level() > 0:
		var extra := 1 if GameState.rejection_actor(str(data.id),id).is_empty() else 2
		check(vn.lines.size() == original_count+extra,"New rejection gets atmosphere and its character response")
		vn.index = vn.lines.size()-1
		vn.show_line()
		vn.revealed = 1000
		await get_tree().process_frame
		check(vn.body.get_line_count()*vn.body.get_line_height() <= vn.body.size.y,"Horror response fits dialogue")
	vn.queue_free()
	await get_tree().process_frame

func _ready() -> void:
	GameState.clear_runtime_state()
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	runner.skip_all()
	var atmosphere: CanvasLayer
	for child in runner.get_children():
		if child.get_script() == preload("res://scripts/opening/horror_atmosphere.gd"):
			atmosphere = child
	check(atmosphere != null,"Runtime atmosphere installed")
	await choose("res://data/home_day1/morning.json","stay")
	check(GameState.horror_level() == 0,"Accepted closeness does not escalate")
	await choose("res://data/home_day1/morning.json","withdraw")
	check(GameState.horror_level() == 1,"Withdrawal gives subtle first stage")
	check(not GameState.record_distance("second_morning","withdraw"),"Repeated decision cannot score twice")
	await choose("res://data/home_day1/clinic_morning.json","clinical")
	check(GameState.horror_level() == 2,"Clinical distance gives second stage")
	await choose("res://data/home_day2/hana_arrival.json","ask_body")
	check(GameState.horror_level() == 3,"Hana boundary reaches third stage")
	GameState.record_distance("hana_memory","wait")
	check(GameState.horror_pressure == 6,"Escalation capped")
	atmosphere._process(10.0)
	check(atmosphere.intensity == 3.0 and atmosphere.veil.visible,"Stage affects atmosphere")
	var before: float = atmosphere.elapsed
	get_tree().paused = true
	await get_tree().create_timer(0.1,true).timeout
	check(atmosphere.elapsed == before,"Pause freezes atmosphere")
	get_tree().paused = false
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/horror_stage3_REVIEW.png")
	GameState.clear_runtime_state()
	atmosphere._process(0.0)
	check(GameState.horror_level() == 0 and not atmosphere.veil.visible and not atmosphere.sound.playing,"Reset clears visual audio and pressure")
	preload("res://scripts/ui/chapter_catalog.gd").prepare("hana")
	check(GameState.horror_level() == 0,"Checkpoint assumptions do not count as player rejections")
	check(not GameState.record_distance("miyako_interior","ask"),"Ordinary inquiry does not count")
	print("HORROR: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
