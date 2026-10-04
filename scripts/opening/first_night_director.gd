extends Node

func build_presentation() -> void:
	presentation = CanvasLayer.new()
	presentation.layer = 26
	add_child(presentation)
	night_image = TextureRect.new()
	night_image.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	night_image.size = Vector2(640,360)
	night_image.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	night_image.mouse_filter = Control.MOUSE_FILTER_IGNORE
	presentation.add_child(night_image)
	night_image.hide()
	photo_back = Panel.new()
	photo_back.position = Vector2(170,40)
	photo_back.size = Vector2(300,170)
	photo_back.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var paper := StyleBoxFlat.new()
	paper.bg_color = Color("#c6b99d")
	paper.border_color = Color("#5e5141")
	paper.set_border_width_all(6)
	photo_back.add_theme_stylebox_override("panel",paper)
	presentation.add_child(photo_back)
	var caption := Label.new()
	caption.text = "FÉNYKÉP\nAkira és Katsuro"
	caption.position = Vector2(20,55)
	caption.size = Vector2(260,65)
	caption.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	caption.add_theme_color_override("font_color",Color("#453d35"))
	caption.add_theme_font_size_override("font_size",21)
	photo_back.add_child(caption)
	photo_back.hide()
	night_cue = AudioStreamPlayer.new()
	add_child(night_cue)

func start_sleep() -> void:
	if phase != "room":
		return
	phase = "settling"
	runner.street.player.input_enabled = false
	runner.street.player.velocity = Vector2.ZERO
	runner.street.player.scripted_axis = Vector2.ZERO
	runner.street.player.hide()
	runner.heading.hide()
	runner.hint.hide()
	var fade := ColorRect.new()
	fade.size = Vector2(640,360)
	fade.color = Color(0,0,0,0)
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	presentation.add_child(fade)
	var tween := create_tween()
	tween.tween_property(fade,"color:a",1.0,0.4)
	await tween.finished
	night_image.texture = load("res://assets/home_day1/akira_sleep_REVIEW.png")
	night_image.show()
	tween = create_tween()
	tween.tween_property(fade,"color:a",0.0,0.5)
	await tween.finished
	fade.queue_free()
	play(read_data("res://data/opening/first_night.json"),"night")

func on_night_line(index: int) -> void:
	if is_instance_valid(shot_tween):
		shot_tween.kill()
	night_image.position = Vector2.ZERO
	night_image.modulate = Color.WHITE
	if index == 1 or index == 2:
		var view := AtlasTexture.new()
		view.atlas = load("res://assets/home_day1/akira_room_REVIEW.png")
		view.region = Rect2(0,0,920,518) if index == 1 else Rect2(600,80,920,518)
		night_image.texture = view
	else:
		night_image.texture = load("res://assets/home_day1/akira_sleep_REVIEW.png")
	var kind := "wind" if index == 1 else ("murmur" if index == 2 else "wood")
	night_cue.stream = runner.ambience.make_effect(kind)
	night_cue.volume_db = -28 if index == 2 else -33
	night_cue.play()
	# Gentle light drift keeps the image still and pixel aligned.
	shot_tween = create_tween()
	shot_tween.tween_property(night_image,"modulate",Color(0.82,0.86,0.95),3.0)
	if index == 2:
		GameState.set_flag("night_voice_noticed")

var card_armed := false
func show_night_end() -> void:
	phase = "dawn_card"
	card_armed = false
	night_cue.stop()
	if is_instance_valid(shot_tween):
		shot_tween.kill()
	end_card = Control.new()
	presentation.add_child(end_card)
	var shade := ColorRect.new()
	shade.size = Vector2(640,360)
	shade.color = Color(0.01,0.02,0.04,0.78)
	shade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	end_card.add_child(shade)
	var title := Label.new()
	title.text = "TSUKIMORI\nA bevezető vége"
	title.position = Vector2(40,105)
	title.size = Vector2(560,80)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size",26)
	end_card.add_child(title)
	var button := Button.new()
	button.text = "Reggel · folytatás"
	button.position = Vector2(215,225)
	button.size = Vector2(210,38)
	button.pressed.connect(start_first_day)
	end_card.add_child(button)
	button.grab_focus()

func _unhandled_input(event: InputEvent) -> void:
	if phase == "dawn_card" and card_armed and event is InputEventKey and event.pressed and not event.echo and event.keycode in [KEY_E,KEY_SPACE,KEY_ENTER]:
		start_first_day()
		get_viewport().set_input_as_handled()

func start_first_day() -> void:
	if phase != "dawn_card" or not card_armed:
		return
	phase = "dawn_transition"
	end_card.queue_free()
	night_image.hide()
	runner.street.show_location("interior")
	runner.street.backdrop.texture = load("res://assets/home_day1/morning_REVIEW.png")
	runner.street.backdrop.scale = Vector2(640.0/runner.street.backdrop.texture.get_width(),360.0/runner.street.backdrop.texture.get_height())
	runner.street.player.show()
	runner.heading.text = "Második reggel"
	runner.heading.show()
	runner.ambience.rain.volume_db = -37
	play(read_data("res://data/home_day1/morning.json"),"morning")
# Owns the chapter transition; all progression requires acknowledgement.
var runner: Node
var done := false
var phase := "room"
var vn: CanvasLayer
var patient_index := 0
var observe_down := false
var presentation: CanvasLayer
var night_image: TextureRect
var photo_back: Panel
var end_card: Control
var night_cue: AudioStreamPlayer
var shot_tween: Tween
var sleep_after_photo := false

func begin() -> void:
	runner.dialogue.hide()
	runner.bubble.hide()
	runner.weather.active = false
	runner.weather.hide()
	runner.heading.show()
	runner.hint.show()
	runner.street.show_location("akira_room")
	runner.ambience.rain.volume_db = -31
	runner.ambience.vehicle.stop()
	GameState.set_flag("visited_akira_room")
	GameState.set_flag("first_night_started")
	build_presentation()
	play(read_data("res://data/home_day1/night_arrival.json"),"room_arrival")

func resume(next_phase: String) -> void:
	phase = next_phase
	observe_down = Input.is_action_pressed("observe")
	runner.street.enable_control()
	runner.hint.show()
	runner.heading.text = "Akira szobája · első este" if phase == "room" else "Rendelő · első nap"
	runner.street.player.show()
	if is_instance_valid(photo_back):
		photo_back.hide()

func advance(_delta: float) -> void:
	var down := Input.is_action_pressed("observe")
	var interact := down and not observe_down
	observe_down = down
	if phase == "dawn_card":
		if not Input.is_action_pressed("observe") and not Input.is_key_pressed(KEY_SPACE) and not Input.is_key_pressed(KEY_ENTER) and not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			card_armed = true
		return
	if phase == "evening_living":
		runner.hint.text = "E · Akira szobája" if runner.street.player.position.x > 435 else "WASD · séta / Shift · futás"
		if interact and runner.street.player.position.x > 435:
			runner.street.show_location("akira_room")
			resume("room")
		return
	if phase not in ["room","clinic"]:
		return
	var x: float = runner.street.player.position.x
	if phase == "room":
		var action := "E · ablak" if x < 160 else ("E · orvosi táska" if x < 250 else ("E · fénykép" if x < 380 else ("E · lefekvés" if x > 460 else "WASD · séta / Shift · futás")))
		runner.hint.text = action + "    Bal szélen: nappali" if x < 110 else action
		if interact:
			if x < 110:
				runner.street.show_location("interior")
				if is_instance_valid(runner.street.featured_actor):
					runner.street.featured_actor.set_active(false)
				runner.street.player.position = Vector2(460,266)
				phase = "evening_living"
				runner.heading.text = "Közös otthon · este"
			elif x < 160:
				play(read_data("res://data/home_day1/night_window.json"),"window")
			elif x < 250:
				play(read_data("res://data/home_day1/night_bag.json"),"bag")
			elif x < 380:
				photo_back.show()
				play(read_data("res://data/home_day1/night_photo.json"),"photo")
			elif x > 460:
				if not GameState.has_flag("katsuro_first_clue_seen"):
					sleep_after_photo = true
					photo_back.show()
					play(read_data("res://data/home_day1/night_photo.json"),"photo")
				else:
					start_sleep()
	else:
		runner.hint.text = "E · következő konzultáció" if x > 240 and x < 390 and patient_index < 2 else ("A mai két konzultáció lezárult.    Tab / Esc · menü" if patient_index == 2 else "Sétálj a konzultáció helyéhez.    WASD · séta")
		if interact and x > 240 and x < 390 and patient_index < 2:
			play(read_data("res://data/home_day1/patient_%d.json" % (patient_index+1)),"patient")

func read_data(path: String) -> Dictionary:
	return JSON.parse_string(FileAccess.get_file_as_string(path))

func play(data: Dictionary, next_phase: String) -> void:
	phase = next_phase
	runner.street.player.input_enabled = false
	runner.street.player.velocity = Vector2.ZERO
	runner.street.player.scripted_axis = Vector2.ZERO
	runner.hint.hide()
	if is_instance_valid(vn):
		vn.queue_free()
	vn = preload("res://scripts/ui/vn_dialogue.gd").new()
	add_child(vn)
	vn.finished.connect(finish_dialogue)
	vn.choice_selected.connect(on_choice)
	if next_phase == "night":
		vn.line_shown.connect(on_night_line)
	vn.begin(data)

func on_choice(id: String) -> void:
	if phase == "morning" and id in ["stay","withdraw"] and GameState.miyako_morning_choice.is_empty():
		GameState.miyako_morning_choice = id
		if id == "stay":
			GameState.aff_miyako += 1
			GameState.akira_gyogyulas += 1
		else:
			GameState.set_flag("flag_miyako_tavolsag")
	elif phase == "clinic_morning" and id in ["empathy","clinical"] and GameState.clinic_first_choice.is_empty():
		GameState.clinic_first_choice = id
		if id == "empathy":
			GameState.aff_hana += 1
			GameState.aff_shion += 1
			GameState.akira_gyogyulas += 1
		else:
			GameState.set_flag("flag_klinikai_tavolsag")

func finish_dialogue() -> void:
	match phase:
		"room_arrival":
			GameState.set_flag("miyako_goodnight_seen")
			resume("room")
		"window":
			GameState.set_flag("night_window_seen")
			resume("room")
		"bag":
			GameState.set_flag("night_bag_seen")
			resume("room")
		"photo":
			GameState.set_flag("katsuro_first_clue_seen")
			resume("room")
			if sleep_after_photo:
				sleep_after_photo = false
				start_sleep()
		"night":
			GameState.set_flag("first_night_seen")
			GameState.set_flag("opening_prologue_complete")
			show_night_end()
		"morning":
			GameState.set_flag("miyako_morning_seen")
			play(read_data("res://data/home_day1/clinic_morning.json"),"clinic_morning")
		"clinic_morning":
			GameState.set_flag("first_clinic_day_started")
			runner.street.show_location("clinic")
			resume("clinic")
		"patient":
			patient_index += 1
			GameState.set_flag("first_day_consultation_%d_seen" % patient_index)
			if patient_index == 2:
				GameState.set_flag("first_clinic_day_seen")
			resume("clinic")
