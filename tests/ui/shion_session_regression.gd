extends "res://tests/ui/hana_day_regression.gd"

func _ready() -> void:
	for melody in ["join_melody","wait_melody"]:
		for tape in ["play_tape","ask_consent"]:
			preload("res://scripts/ui/chapter_catalog.gd").prepare("shion")
			var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
			add_child(runner)
			await get_tree().process_frame
			var day: Node = runner.arrival.next_day
			check(day.phase == "shion_arrival" and not GameState.has_flag("met_shion"),"Checkpoint preserves first introduction")
			check(not runner.street.player.visible,"Consultation stays VN-only")
			check(day.vn.portrait.flip_h and not day.vn.akira_portrait.flip_h,"Characters face inward")
			await finish(day.vn,melody)
			check(day.phase == "shion_memory" and GameState.has_flag("met_shion"),"Meeting and melody advance")
			await finish(day.vn,tape)
			check(day.phase == "shion_close" and GameState.has_flag("shion_tape_found"),"Tape clue precedes closing")
			await finish(day.vn)
			check(day.phase == "shion_complete" and GameState.has_flag("shion_first_session_seen"),"Consultation completes")
			check(GameState.has_flag("shion_shared_memory_seen"),"Shared memory revealed")
			var affinity := (2 if melody == "join_melody" else 0)+(1 if tape == "ask_consent" else 0)
			check(GameState.aff_shion == affinity,"Canonical affinity preserved")
			check(GameState.akira_gyogyulas == (1 if melody == "wait_melody" else 0)+(1 if tape == "ask_consent" else 0),"Canonical healing preserved")
			check(GameState.akira_elmerules == (1 if melody == "join_melody" else 0)+(2 if tape == "play_tape" else 0),"Canonical immersion preserved")
			day.phase = "shion_arrival"
			day.on_choice(melody)
			day.phase = "shion_memory"
			day.on_choice(tape)
			day.phase = "shion_complete"
			check(GameState.aff_shion == affinity,"Repeated callbacks cannot double rewards")
			var entries := preload("res://scripts/ui/character_journal.gd").entries()
			var entry: Dictionary = entries.filter(func(e): return e.id == "shion")[0]
			check(entry.known and not entry.has("crop"),"Journal reveals full portrait")
			check("Megtaláltátok az AKIRA — SHION feliratú kazettát." in entry.events and "Közös gyermekkori emléket láttatok a vízben." in entry.events,"Journal retains the two earned memories")
			check(("Bekapcsolódtál a dallamába." in entry.events) == (melody == "join_melody"),"Journal records the chosen melody branch")
			check(("Hagytál neki időt a dallamra." in entry.events) == (melody == "wait_melody"),"Journal excludes the unchosen melody branch")
			check(("A kazetta lejátszása előtt kikérted a beleegyezését." in entry.events) == (tape == "ask_consent"),"Journal does not invent consent")
			check(load(entry.portrait).get_image().get_pixel(0,0).a < 0.1,"Portrait has alpha")
			runner.pause_menu.open_menu()
			runner.pause_menu.show_characters()
			for i in runner.pause_menu.journal_entries.size():
				if runner.pause_menu.journal_entries[i].id == "shion": runner.pause_menu.show_character(i)
			await capture("shion_journal_REVIEW")
			runner.pause_menu.resume()
			runner.queue_free()
			await get_tree().process_frame
	GameState.clear_runtime_state()
	check(GameState.aff_shion == 0 and not GameState.has_flag("met_shion"),"Reset clears Shion progress")
	print("SHION_SESSION: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
