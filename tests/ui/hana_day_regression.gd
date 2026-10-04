extends Node
var failures: Array[String] = []
func check(ok: bool, message: String) -> void:
	if not ok:
		failures.append(message)
		push_error(message)

func finish(vn: CanvasLayer, choice := "") -> void:
	for step in 450:
		if not is_instance_valid(vn) or not vn.active:
			return
		if vn.choice_box.visible:
			var found := false
			for option in vn.choices:
				if option.id == choice:
					for i in vn.choices.size():
						if vn.choices[i].id == choice:
							vn.choice_box.get_child(i).grab_focus()
							check(vn.choice_box.get_child(i).position.x+vn.choice_box.get_child(i).size.x <= 616,"Choice fits screen")
							await capture("hana_boundary_choice_REVIEW" if choice in ["ask_body","let_lead"] else "hana_memory_choice_REVIEW")
							await key(KEY_ENTER)
							break
					found = true
					break
			check(found,"Expected choice exists: "+choice)
			if not found:
				return
		else:
			vn.advance()
		await get_tree().process_frame
		if is_instance_valid(vn) and vn.active:
			check(vn.body.position.y+vn.body.size.y <= vn.next_button.position.y-4,"Text clears controls: "+vn.body.text)
	check(false,"Dialogue terminates")

func key(code: Key) -> void:
	var press := InputEventKey.new()
	press.keycode = code
	press.physical_keycode = code
	press.pressed = true
	Input.parse_input_event(press)
	await get_tree().process_frame
	var release := InputEventKey.new()
	release.keycode = code
	release.physical_keycode = code
	Input.parse_input_event(release)
	await get_tree().process_frame

func capture(file: String) -> void:
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/"+file+".png")

func _ready() -> void:
	for boundary in ["ask_body","let_lead"]:
		for memory in ["recall","wait"]:
			GameState.clear_runtime_state()
			GameState.set_flag("first_day_complete")
			GameState.set_flag("hana_name_heard")
			GameState.set_flag("hana_cameo_seen")
			var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
			add_child(runner)
			runner.skip_all()
			var chapter: Node = load("res://scripts/opening/first_night_director.gd").new()
			runner.arrival = chapter
			runner.add_child(chapter)
			chapter.runner = runner
			chapter.build_presentation()
			chapter.hide_actors()
			chapter.show_day_end()
			Input.action_press("observe")
			await get_tree().process_frame
			chapter.start_hana_day()
			check(not is_instance_valid(chapter.next_day),"Held input cannot carry across day ending")
			Input.action_release("observe")
			await get_tree().process_frame
			await key(KEY_SPACE)
			var day: Node = chapter.next_day
			check(is_instance_valid(day) and day.phase == "night_notebook","Day-one card connects to next chapter")
			await finish(day.vn)
			check(GameState.has_flag("katsuro_returned_notebook_seen") and day.phase == "morning_hana","Night clue leads to morning")
			check(not GameState.has_flag("met_hana"),"File and note do not invent a meeting")
			await finish(day.vn)
			check(day.phase == "hana_arrival" and not GameState.has_flag("met_hana"),"Arrival begins before personal greeting")
			for step in 10:
				if GameState.has_flag("met_hana"):
					break
				day.vn.advance()
				await get_tree().process_frame
			check(GameState.has_flag("met_hana"),"Personal greeting reveals Hana")
			check(not runner.street.player.visible and not runner.street.player.input_enabled,"Clinic stays VN-only")
			day.vn.advance()
			await capture("hana_first_meeting_REVIEW")
			runner.pause_menu.open_menu()
			var before: float = day.vn.revealed
			await get_tree().create_timer(0.2).timeout
			check(day.vn.revealed == before,"Menu pauses Hana dialogue")
			runner.pause_menu.resume()
			await finish(day.vn,boundary)
			check(day.phase == "hana_memory","Boundary branch rejoins the full conversation")
			check(day.vn.portrait.texture.resource_path.ends_with("hana_guarded_v1_REVIEW.png"),"Serious conversation uses guarded expression")
			var points: int = GameState.aff_hana
			day.on_choice(boundary)
			check(GameState.aff_hana == points,"First choice cannot apply twice")
			await finish(day.vn,memory)
			check(day.phase == "hana_close","Memory branch rejoins appointment ending")
			points = GameState.aff_hana
			day.on_choice(memory)
			check(GameState.aff_hana == points,"Memory choice cannot apply twice")
			await finish(day.vn)
			check(day.phase == "hana_complete" and GameState.has_flag("hana_first_session_seen"),"Only final farewell completes the session")
			check(GameState.aff_hana == (1 if boundary == "ask_body" else 0)+(2 if memory == "recall" else 0),"Original Hana affinity effects")
			check(GameState.akira_gyogyulas == (1 if boundary == "ask_body" else 0)+(1 if memory == "wait" else 0),"Original healing effects")
			check(GameState.akira_elmerules == (1 if memory == "recall" else 0),"Original immersion effect")
			check(GameState.hana_first_choice == boundary and GameState.hana_memory_choice == memory,"Choices retained")
			var entries: Array[Dictionary] = preload("res://scripts/ui/character_journal.gd").entries()
			var hana: Dictionary = entries.filter(func(item: Dictionary): return item.id == "hana")[0]
			check(hana.known and hana.events.size() == 3,"Journal shows completed earned knowledge")
			runner.pause_menu.open_menu()
			runner.pause_menu.show_characters()
			runner.pause_menu.show_character(1)
			await capture("hana_character_sheet_REVIEW")
			runner.pause_menu.resume()
			runner.queue_free()
			await get_tree().process_frame
	GameState.clear_runtime_state()
	check(GameState.hana_first_choice.is_empty() and GameState.hana_memory_choice.is_empty() and GameState.akira_elmerules == 0,"New game clears Hana choices")
	print("HANA_DAY: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
