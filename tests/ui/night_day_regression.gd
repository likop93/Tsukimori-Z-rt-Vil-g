extends Node
var failures: Array[String] = []
func check(ok: bool, message: String) -> void:
	if not ok:
		failures.append(message)
		push_error(message)
func finish(vn: CanvasLayer, choice := "") -> void:
	for step in 100:
		if not is_instance_valid(vn) or not vn.active:
			return
		if vn.choice_box.visible:
			var options: Array = vn.choices
			for option in options:
				if option.id == choice:
					vn.select_choice(option)
					break
		else:
			vn.advance()
		await get_tree().process_frame
		if is_instance_valid(vn) and vn.active:
			check(vn.body.get_line_count()*vn.body.get_line_height() <= vn.body.size.y,"Dialogue fits: "+vn.body.text)
	check(false,"Dialogue failed to terminate")
func capture(file: String) -> void:
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/"+file+".png")
func interact() -> void:
	Input.action_press("observe")
	await get_tree().process_frame
	await get_tree().process_frame
	Input.action_release("observe")
	await get_tree().process_frame
func _ready() -> void:
	for branch in 2:
		GameState.clear_runtime_state()
		var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
		add_child(runner)
		runner.skip_all()
		var previous: Node = runner.arrival
		var night: Node = load("res://scripts/opening/first_night_director.gd").new()
		runner.arrival = night
		runner.add_child(night)
		night.runner = runner
		night.begin()
		if is_instance_valid(previous):
			previous.queue_free()
		await get_tree().process_frame
		check(runner.street.location == "akira_room" and runner.street.player.input_enabled,"Room exploration returns control")
		check(not GameState.has_flag("first_night_seen"),"Room entry does not finish night")
		await capture("night_room_REVIEW")
		runner.street.player.position = Vector2(310,276)
		await interact()
		check(night.phase == "photo","E at desk opens photo")
		await finish(night.vn)
		check(GameState.has_flag("katsuro_first_clue_seen"),"Photo acknowledgement records clue")
		runner.street.player.position = Vector2(490,276)
		await interact()
		check(night.phase == "night","E at bed starts night")
		await finish(night.vn)
		check(GameState.has_flag("first_night_seen") and night.phase == "morning","Night continues into morning")
		check(not runner.street.player.input_enabled,"Morning dialogue locks movement")
		await capture("morning_REVIEW")
		await finish(night.vn,"stay" if branch == 0 else "withdraw")
		check(GameState.has_flag("miyako_morning_seen"),"Morning is acknowledged")
		var affinity: int = GameState.aff_miyako
		night.on_choice("stay")
		check(GameState.aff_miyako == affinity,"Morning effect cannot be repeated")
		await finish(night.vn,"empathy" if branch == 0 else "clinical")
		check(GameState.aff_miyako == (1 if branch == 0 else 0),"Canonical morning affinity")
		check(GameState.aff_hana == (1 if branch == 0 else 0),"Canonical clinic effect")
		check(GameState.akira_gyogyulas == (2 if branch == 0 else 0),"Canonical healing effects")
		check(runner.street.location == "clinic" and runner.street.player.input_enabled,"Clinic opens as playable scene")
		check(not GameState.has_flag("first_clinic_day_seen"),"Starting day does not complete consultations")
		await capture("clinic_REVIEW")
		for i in 2:
			runner.street.player.position = Vector2(310,276)
			await interact()
			check(night.phase == "patient","E opens next consultation")
			check(not runner.street.player.input_enabled,"Consultation locks movement")
			await finish(night.vn)
			check(GameState.has_flag("first_day_consultation_%d_seen" % (i+1)),"Acknowledged consultation recorded")
			check(GameState.has_flag("first_clinic_day_seen") == (i == 1),"Day completes only after second consultation")
		var grounded: Vector2 = runner.street.constrain_position(Vector2(1000,0))
		check(grounded == Vector2(495,272),"Clinic feet remain inside clear floor strip")
		runner.queue_free()
		await get_tree().process_frame
	print("NIGHT_DAY: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
