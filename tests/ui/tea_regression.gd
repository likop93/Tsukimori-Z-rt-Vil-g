extends "res://tests/ui/hana_day_regression.gd"

func _ready() -> void:
	for stage in 3:
		for choice in ["closer","slow","friends"]:
			preload("res://scripts/ui/chapter_catalog.gd").prepare("tea")
			if stage > 0:
				GameState.record_distance("second_morning","withdraw")
				GameState.record_distance("miyako_afternoon","keep_distance")
			if stage > 1:
				# Future-state asset fixture, not reachable in current story.
				GameState.set_flag("miyako_transformation_revealed")
			var pressure := GameState.horror_pressure
			var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
			add_child(runner)
			await get_tree().process_frame
			var day: Node = runner.arrival.next_day
			var vn: CanvasLayer = day.vn
			check(day.phase == "miyako_tea","Checkpoint opens tea")
			check(GameState.day == 3 and GameState.time_of_day == "evening","Tea checkpoint calendar without affinity rewards")
			check(not runner.street.player.visible and not runner.street.player.input_enabled,"Tea is VN-only")
			check(vn.akira_portrait.texture.resource_path.ends_with("akira_doctor_green_eye_v1_REVIEW.png"),"Akira retains his changed eye")
			check(not GameState.has_flag("miyako_evening_outfit_seen"),"Outfit is not unlocked before the personal scene")
			for step in 150:
				if not vn.active:
					break
				if vn.choice_box.visible:
					await get_tree().process_frame
					check(vn.choice_box.get_global_rect().end.y < vn.dialogue_panel.get_global_rect().position.y,"All three choices clear dialogue")
					if stage == 0 and choice == "closer":
						await capture("tea_choices_REVIEW")
					for i in vn.choices.size():
						if vn.choices[i].id == choice:
							vn.choice_box.get_child(i).grab_focus()
							await key(KEY_ENTER)
							break
				else:
					vn.advance()
				await get_tree().process_frame
				if vn.active:
					check(vn.body.get_line_count()*vn.body.get_line_height() <= vn.body.size.y,"Tea text fits")
					if vn.outfit == "evening":
						var expected := preload("res://scripts/ui/character_reactions.gd").outfit_portrait("miyako","evening")
						check(vn.portrait_source_path == expected,"Evening outfit respects horror stage")
						if not reactions.has(expected):
							reactions[expected] = true
							vn.revealed = vn.body.get_total_character_count()
							vn.body.visible_characters = vn.body.get_total_character_count()
							await capture("tea_stage"+str(stage)+"_REVIEW")
			check(day.phase == "tea_complete","Every tea choice reaches ending")
			check(GameState.personal_choices.get("miyako_tea","") == choice,"Personal choice recorded")
			check(not GameState.record_personal_choice("miyako_tea","slow"),"Repeated choice cannot overwrite")
			check(GameState.horror_pressure == pressure and GameState.character_stage("miyako") == stage,"Personal agreement does not erase or add horror")
			check(GameState.aff_miyako == 0,"Canonical affinity is unchanged")
			check(GameState.has_flag("miyako_tea_complete"),"Completion flag reached")
			runner.pause_menu.open_menu()
			runner.pause_menu.show_characters()
			for i in runner.pause_menu.journal_entries.size():
				if runner.pause_menu.journal_entries[i].id == "miyako":
					runner.pause_menu.show_character(i)
					break
			var toggle: Button = runner.pause_menu.body.get_node("MiyakoWardrobePreview")
			check(is_instance_valid(toggle),"Earned outfit appears in journal")
			toggle.button_pressed = true
			await get_tree().process_frame
			var preview_found := false
			for child in runner.pause_menu.body.get_children():
				if child is TextureRect:
					preview_found = child.texture.resource_path == preload("res://scripts/ui/character_reactions.gd").outfit_portrait("miyako","evening")
			check(preview_found,"Journal preview uses matching transformed wardrobe")
			if stage == 0 and choice == "closer":
				await capture("tea_journal_REVIEW")
			check(GameState.personal_choices.get("miyako_tea","") == choice and GameState.horror_pressure == pressure,"Journal is read-only")
			runner.pause_menu.resume()
			runner.queue_free()
			await get_tree().process_frame
	GameState.clear_runtime_state()
	check(GameState.personal_choices.is_empty() and not GameState.has_flag("miyako_evening_outfit_seen"),"New game clears relationship and wardrobe")
	check(not GameState.record_personal_choice("unknown","closer"),"Unknown scene cannot mutate state")
	print("TEA: "+JSON.stringify({"passed":failures.is_empty(),"combinations":9,"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
