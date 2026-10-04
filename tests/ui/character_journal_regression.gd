extends Node
var failures: Array[String] = []
func check(ok: bool, message: String) -> void:
	if not ok:
		failures.append(message)
		push_error(message)
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	GameState.clear_runtime_state()
	var journal = preload("res://scripts/ui/character_journal.gd")
	check(journal.entries().size() == 1,"New game reveals only Akira")
	for flag in ["hana_cameo_seen","kuroe_cameo_passed","shion_cameo_seen"]:
		GameState.set_flag(flag)
	var entries: Array[Dictionary] = journal.entries()
	check(entries.size() == 4,"Seen cameos are recorded")
	for entry in entries:
		if entry.id != "akira":
			check(not entry.known and entry.title == "Ismeretlen nő","Cameo never reveals identity")
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	runner.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(runner)
	runner.skip_all()
	var menu: CanvasLayer = runner.pause_menu
	menu.open_menu()
	menu.show_characters()
	menu.show_character(1)
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/character_unknown_REVIEW.png")
	check(get_tree().paused,"Journal keeps world paused")
	GameState.set_flag("met_miyako")
	GameState.set_flag("miyako_interior_dialogue_seen")
	GameState.miyako_first_choice = "listen"
	GameState.aff_miyako = 1
	var before := JSON.stringify(GameState.flags)
	menu.show_characters()
	menu.show_character(1)
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/character_miyako_REVIEW.png")
	check(menu.journal_entries[1].title == "Miyako" and menu.journal_entries[1].events.size() == 3,"Miyako description tracks earned story knowledge")
	check(GameState.aff_miyako == 1 and GameState.miyako_first_choice == "listen" and JSON.stringify(GameState.flags) == before,"Journal is read-only")
	for child in menu.body.get_children():
		if child is Label:
			check(child.get_line_count()*child.get_line_height() <= child.size.y,"Character text fits its region")
	menu.back()
	check(menu.page == "main" and get_tree().paused,"Back returns to pause menu")
	menu.resume()
	GameState.clear_runtime_state()
	check(journal.entries().size() == 1,"New game clears old knowledge")
	print("CHARACTER_JOURNAL: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
