extends "res://tests/ui/hana_day_regression.gd"

func _ready() -> void:
	await get_tree().process_frame
	GameState.clear_runtime_state()
	GameState.set_flag("met_hana")
	GameState.set_flag("hana_transformation_revealed")
	GameState.record_distance("hana_arrival","ask_body")
	GameState.record_distance("hana_memory","wait")
	GameState.record_personal_choice("miyako_tea","slow")
	var state := JSON.stringify([GameState.flags,GameState.horror_events,GameState.horror_pressure,GameState.personal_choices,GameState.aff_hana,GameState.aff_miyako])
	var menu: Control = load("res://scenes/ui/main_menu.tscn").instantiate()
	get_tree().root.add_child(menu)
	get_tree().current_scene = menu
	await get_tree().process_frame
	for button in menu.buttons:
		check(button.get_global_rect().end.y < 333,"Main menu buttons fit above footer")
	menu.gallery_button.grab_focus()
	await key(KEY_ENTER)
	await get_tree().process_frame
	var gallery: Control = get_tree().current_scene
	check(gallery.scene_file_path.ends_with("character_gallery.tscn"),"Main menu opens gallery")
	for i in gallery.profiles.size():
		gallery.select_character(i)
		var spec: Dictionary = gallery.profiles[i]
		check(gallery.portrait.texture.resource_path == str(spec.casual),"Casual portrait loads")
		check(gallery.portrait.texture.get_image().get_pixel(0,0).a < 0.1,"Full body cutout has transparency")
		await capture("gallery_"+str(spec.id)+"_REVIEW")
		gallery.toggle_outfit()
		check(gallery.portrait.texture.resource_path == str(spec.portrait),"Original design remains selectable")
		gallery.toggle_outfit()
		for option in spec.choices:
			gallery.start_sample()
			var dialogue: CanvasLayer = gallery.vn
			check(dialogue.preview_mode and dialogue.portrait_source_path == str(spec.casual),"Sample ignores live horror appearance")
			for step in 90:
				if not is_instance_valid(dialogue) or not dialogue.active:
					break
				if dialogue.choice_box.visible:
					await get_tree().process_frame
					check(dialogue.choice_box.get_global_rect().end.y < dialogue.dialogue_panel.position.y,"Three choices do not cover text")
					for j in dialogue.choices.size():
						if dialogue.choices[j].id == option.id:
							dialogue.choice_box.get_child(j).grab_focus()
							await key(KEY_ENTER)
							break
				else:
					dialogue.advance()
				await get_tree().process_frame
				if is_instance_valid(dialogue) and dialogue.active:
					check(dialogue.body.get_line_count()*dialogue.body.get_line_height() <= dialogue.body.size.y,"Sample text fits")
			check(gallery.page.visible and not is_instance_valid(gallery.vn),"Sample completes and returns to gallery")
			check(JSON.stringify([GameState.flags,GameState.horror_events,GameState.horror_pressure,GameState.personal_choices,GameState.aff_hana,GameState.aff_miyako]) == state,"Gallery cannot mutate story state")
	gallery.start_sample()
	await key(KEY_ESCAPE)
	check(gallery.page.visible,"Escape closes sample")
	await key(KEY_ESCAPE)
	await get_tree().process_frame
	check(get_tree().current_scene.scene_file_path.ends_with("main_menu.tscn"),"Escape returns to main menu")
	GameState.clear_runtime_state()
	GameState.set_flag("kuroe_cameo_passed")
	var entries := preload("res://scripts/ui/character_journal.gd").entries()
	var kuroe: Dictionary = entries.filter(func(entry): return entry.id == "kuroe")[0]
	check(not kuroe.known and not kuroe.has("outfit_preview"),"Gallery does not reveal Kuroe in story journal")
	print("CHARACTER_GALLERY: "+JSON.stringify({"passed":failures.is_empty(),"branches":9,"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
