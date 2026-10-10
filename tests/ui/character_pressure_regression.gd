extends "res://tests/ui/horror_progression_regression.gd"

func _ready() -> void:
	GameState.clear_runtime_state()
	GameState.set_flag("met_miyako")
	GameState.set_flag("met_hana")
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	runner.skip_all()
	await choose("res://data/home_day1/morning.json","withdraw")
	check(GameState.character_stage("miyako") == 1 and GameState.character_stage("hana") == 0,"Personal rejection remains isolated")
	await choose("res://data/home_day1/clinic_morning.json","clinical")
	check(GameState.character_stage("miyako") == 1 and GameState.character_stage("hana") == 0,"General clinical stance is not personal rejection")
	await choose("res://data/home_day2/miyako_afternoon.json","keep_distance")
	check(GameState.character_stage("miyako") == 2,"Repeated Miyako rejection escalates")
	var transformed_vn := preload("res://scripts/ui/vn_dialogue.gd").new()
	add_child(transformed_vn)
	var afternoon: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/home_day2/miyako_afternoon.json"))
	transformed_vn.begin(afternoon)
	for expression in ["neutral","warm","worried","sad"]:
		transformed_vn.lines[0]["expression"] = expression
		transformed_vn.index = 0
		transformed_vn.show_line()
		check(transformed_vn.portrait.texture.resource_path.ends_with("miyako_transformed_manic_v1_REVIEW.png"),"Transformation persists across "+expression)
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/miyako_transformed_dialogue_REVIEW.png")
	transformed_vn.queue_free()
	await get_tree().process_frame
	await choose("res://data/home_day2/hana_arrival.json","ask_body")
	await choose("res://data/home_day2/hana_memory.json","wait")
	check(GameState.character_stage("hana") == 2,"Hana has her own escalation")
	check(GameState.character_response("hana").text.contains("Így maradjak?"),"Hana seeks approval rather than demands compliance")
	var hana_vn := preload("res://scripts/ui/vn_dialogue.gd").new()
	add_child(hana_vn)
	var hana_data: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/home_day2/hana_arrival.json"))
	hana_vn.begin(hana_data)
	for expression in ["neutral","warm","guarded","sad"]:
		hana_vn.lines[0]["expression"] = expression
		hana_vn.index = 0
		hana_vn.show_line()
		check(hana_vn.portrait.texture.resource_path.ends_with("hana_transformed_deferential_v1_REVIEW.png"),"Hana transformation persists across "+expression)
	hana_vn.queue_free()
	await get_tree().process_frame
	var entries := preload("res://scripts/ui/character_journal.gd").entries()
	for id in ["miyako","hana"]:
		var entry: Dictionary = entries.filter(func(item): return item.id == id)[0]
		check(entry.reaction_stage == 2,"Journal tracks "+id)
		check(ResourceLoader.exists(entry.portrait),"Portrait exists for "+id)
		var image: Image = load(entry.portrait).get_image()
		check(image.get_pixel(0,0).a < 0.1,"Portrait remains transparent")
		runner.pause_menu.open_menu()
		runner.pause_menu.show_characters()
		runner.pause_menu.show_character(1 if id == "miyako" else 2)
		await RenderingServer.frame_post_draw
		get_viewport().get_texture().get_image().save_png("res://review/"+id+"_pressure_sheet_REVIEW.png")
		if id == "hana":
			var wardrobe: Button = runner.pause_menu.body.get_node("HanaWardrobePreview")
			wardrobe.button_pressed = true
			await RenderingServer.frame_post_draw
			check(wardrobe.text == "Kimonó","Casual wardrobe preview can return to kimono")
			get_viewport().get_texture().get_image().save_png("res://review/hana_casual_sheet_REVIEW.png")
			wardrobe.button_pressed = false
			check(GameState.character_stage("hana") == 2,"Clothing preview leaves story state untouched")
		runner.pause_menu.resume()
	var pressure: int = GameState.character_pressure("hana")
	GameState.record_distance("hana_memory","wait")
	check(GameState.character_pressure("hana") == pressure,"Repeated callbacks do not escalate again")
	GameState.clear_runtime_state()
	GameState.set_flag("hana_cameo_seen")
	entries = preload("res://scripts/ui/character_journal.gd").entries()
	var unknown: Dictionary = entries.filter(func(item): return item.id == "hana")[0]
	check(not unknown.known and not unknown.has("reaction_label"),"Unknown character does not reveal reaction data")
	check(GameState.character_stage("hana") == 0 and GameState.character_stage("miyako") == 0,"Reset clears personal states")
	print("CHARACTER_PRESSURE: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
