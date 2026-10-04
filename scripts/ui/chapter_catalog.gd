extends RefCounted
# Implemented review checkpoints only; no save or route unlock system.
static func entries() -> Array[Dictionary]:
	return [
		{"id":"intro","title":"Nyitány · Akira érkezése"},
		{"id":"village","title":"Falusi séta · a kaputól"},
		{"id":"miyako","title":"I. Miyako · első találkozás"},
		{"id":"night","title":"II. Az első éjszaka"},
		{"id":"clinic","title":"III. Az első rendelési nap"},
		{"id":"hana","title":"IV. Hana · első beszélgetés"},
	]

static func valid(id: String) -> bool:
	for entry in entries():
		if entry.id == id:
			return true
	return false

static func prepare(id: String) -> bool:
	if not valid(id):
		return false
	GameState.clear_runtime_state()
	GameState.chapter_start = id
	if id == "intro":
		return true
	for flag in ["opening_intro_seen","entered_tsukimori"]:
		GameState.set_flag(flag)
	if id == "village":
		return true
	GameState.set_flag("crossed_bridge")
	if id == "miyako":
		return true
	for flag in ["met_miyako","miyako_first_dialogue_seen","entered_shared_home","miyako_interior_dialogue_seen"]:
		GameState.set_flag(flag)
	# Canonical zero-point alternatives; skipped decisions award no points.
	GameState.miyako_first_choice = "ask"
	if id == "night":
		return true
	for flag in ["visited_akira_room","first_night_started","miyako_goodnight_seen","katsuro_first_clue_seen","first_night_seen","night_voice_noticed","opening_prologue_complete"]:
		GameState.set_flag(flag)
	if id == "clinic":
		return true
	GameState.miyako_morning_choice = "withdraw"
	GameState.clinic_first_choice = "clinical"
	for flag in ["miyako_morning_seen","flag_miyako_tavolsag","flag_klinikai_tavolsag","first_clinic_day_started","first_day_consultation_1_seen","first_day_consultation_2_seen","first_clinic_day_seen","katsuro_clinic_notebook_seen","miyako_first_day_evening_seen","hana_name_heard","first_day_complete"]:
		GameState.set_flag(flag)
	return true

static func enter(runner: Node, id: String) -> void:
	if id == "intro" or not valid(id):
		return
	runner.skip_all()
	if id == "village":
		return
	if id == "miyako":
		runner.street.show_location("house")
		runner.street.player.position = Vector2(275,274)
		runner.street.player.input_enabled = false
		runner.heading.text = "Miyako háza"
		runner.arrival = preload("res://scripts/opening/arrival_director.gd").new()
		runner.add_child(runner.arrival)
		runner.arrival.runner = runner
		runner.arrival.show_miyako()
		runner.arrival.elapsed = 1.6
		return
	runner.weather.active = false
	runner.weather.hide()
	runner.dialogue.hide()
	runner.bubble.hide()
	var chapter := preload("res://scripts/opening/first_night_director.gd").new()
	runner.arrival = chapter
	runner.add_child(chapter)
	chapter.runner = runner
	if id == "night":
		chapter.begin()
		return
	chapter.build_presentation()
	chapter.hide_actors()
	if id == "clinic":
		chapter.begin_first_day()
	elif id == "hana":
		chapter.begin_hana_day()
