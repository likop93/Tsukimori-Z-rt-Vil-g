extends Node
signal handoff_completed
const Street := preload("res://scenes/opening/village_street.tscn")
const Weather := preload("res://scripts/opening/weather.gd")
const Ambience := preload("res://scripts/opening/ambience.gd")
var street: Node2D
var weather: Node2D
var ambience: Node
var beats: Array
var words: Dictionary
var beat_index := 0
var beat_time := 0.0
var line_index := -1
var reveal_time := 0.0
var completed := false
var handoff_count := 0
var auto_advance := true
var overlay: Control
var shot: TextureRect
var matte: ColorRect
var narration: Label
var dialogue: Panel
var hint: Label
var heading: Label
var bubble: Label
var skip_dialog: ConfirmationDialog
var fade: Tween
var bubble_time := 0.0
var bubble_anchor := Vector2.ZERO
var shown_phrases: Dictionary = {}
var help_visible := true

func _ready() -> void:
	install_input()
	beats = JSON.parse_string(FileAccess.get_file_as_string("res://data/opening/sequence.json")).beats
	words = JSON.parse_string(FileAccess.get_file_as_string("res://data/opening/village.json")).ui
	street = Street.instantiate()
	add_child(street)
	ambience = Ambience.new()
	add_child(ambience)
	var canvas := CanvasLayer.new()
	add_child(canvas)
	overlay = Control.new()
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	canvas.add_child(overlay)
	matte = ColorRect.new()
	matte.color = Color.BLACK
	matte.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	matte.mouse_filter = Control.MOUSE_FILTER_IGNORE
	overlay.add_child(matte)
	shot = TextureRect.new()
	shot.position = Vector2(0,0)
	shot.size = Vector2(640,360)
	shot.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	shot.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	shot.mouse_filter = Control.MOUSE_FILTER_IGNORE
	overlay.add_child(shot)
	weather = Weather.new()
	canvas.add_child(weather)
	dialogue = Panel.new()
	dialogue.position = Vector2(42,268)
	dialogue.size = Vector2(556,66)
	dialogue.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.025,0.025,0.045,0.93)
	style.border_color = Color("#97556a")
	style.set_border_width_all(1)
	style.corner_radius_top_left = 3
	style.corner_radius_bottom_right = 3
	dialogue.add_theme_stylebox_override("panel",style)
	canvas.add_child(dialogue)
	narration = make_label(dialogue,Vector2(16,10),Vector2(524,50),16)
	narration.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	heading = make_label(canvas,Vector2(28,20),Vector2(584,35),19)
	heading.text = "TSUKIMORI"
	heading.add_theme_color_override("font_color",Color("#efd0a5"))
	hint = make_label(canvas,Vector2(30,342),Vector2(580,17),10)
	hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	bubble = make_label(canvas,Vector2(150,150),Vector2(250,34),13)
	bubble.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	bubble.add_theme_color_override("font_shadow_color",Color.BLACK)
	bubble.add_theme_constant_override("shadow_offset_x",1)
	bubble.add_theme_constant_override("shadow_offset_y",1)
	bubble.hide()
	skip_dialog = ConfirmationDialog.new()
	skip_dialog.title = "Tsukimori"
	skip_dialog.dialog_text = words.skip
	skip_dialog.ok_button_text = words.yes
	skip_dialog.cancel_button_text = words.no
	skip_dialog.confirmed.connect(finish_intro)
	canvas.add_child(skip_dialog)
	set_beat(0)

func make_label(parent: Node, at: Vector2, dimensions: Vector2, font_size: int) -> Label:
	var label := Label.new()
	label.position = at
	label.size = dimensions
	label.add_theme_font_size_override("font_size",font_size)
	label.add_theme_color_override("font_color",Color("#f0e6dd"))
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	parent.add_child(label)
	return label

func install_input() -> void:
	var mapping := {
		"walk_left":[KEY_A,KEY_LEFT],"walk_right":[KEY_D,KEY_RIGHT],
		"walk_up":[KEY_W,KEY_UP],"walk_down":[KEY_S,KEY_DOWN],
		"observe":[KEY_E]
	}
	for action in mapping:
		if not InputMap.has_action(action):
			InputMap.add_action(action)
		for code in mapping[action]:
			var event := InputEventKey.new()
			event.physical_keycode = code
			if not InputMap.action_has_event(action,event):
				InputMap.action_add_event(action,event)

func _process(delta: float) -> void:
	if completed:
		update_ambient(delta)
		return
	if skip_dialog.visible:
		return
	beat_time += delta
	reveal_time += delta
	var beat: Dictionary = beats[beat_index]
	var lines: Array = beat.lines
	if not lines.is_empty():
		var next_line := mini(lines.size()-1,int(beat_time / (float(beat.duration)/lines.size())))
		if next_line != line_index:
			line_index = next_line
			reveal_time = 0
			narration.text = lines[line_index]
		narration.visible_characters = int(reveal_time*34)
	if beat_index == 4:
		# Reveal the already-instantiated street before input unlock: same actor and spawn.
		overlay.modulate.a = 1.0-clampf((beat_time-(float(beat.duration)-2.5))/2.5,0,1)
	if beat_index == 5:
		overlay.modulate.a = 0
		dialogue.modulate.a = overlay.modulate.a
	if auto_advance and beat_time >= float(beat.duration):
		if beat_index == beats.size()-1:
			finish_intro()
		else:
			set_beat(beat_index+1)

func set_beat(index: int) -> void:
	beat_index = index
	beat_time = 0
	reveal_time = 0
	line_index = -1
	overlay.modulate.a = 1.0
	dialogue.modulate.a = 1.0
	var beat: Dictionary = beats[index]
	dialogue.visible = not beat.lines.is_empty()
	heading.visible = false
	hint.text = words.intro
	hint.visible = index > 0
	weather.active = index != 0
	weather.visible = index != 0
	if index == 5:
		# Street is already alive beneath the gate shot: no scene/audio reload.
		dialogue.hide()
		return
	if fade != null:
		fade.kill()
	shot.visible = not str(beat.image).is_empty()
	if shot.visible:
		shot.texture = load("res://assets/opening/generated/"+str(beat.image)+"_REVIEW.png")
		shot.modulate.a = 0
		fade = create_tween()
		fade.tween_property(shot,"modulate:a",1.0,0.8)
	if index == 3:
		ambience.leave_vehicle()

func advance_line() -> void:
	if completed or skip_dialog.visible:
		return
	var beat: Dictionary = beats[beat_index]
	if narration.visible_characters < narration.text.length() and dialogue.visible:
		reveal_time = 100
		narration.visible_characters = -1
		return
	if not beat.lines.is_empty() and line_index < beat.lines.size()-1:
		beat_time = (line_index+1)*float(beat.duration)/beat.lines.size()+0.01
	elif beat_index < beats.size()-1:
		set_beat(beat_index+1)
	else:
		finish_intro()

func request_skip() -> void:
	if completed:
		return
	if GameState.has_flag("opening_intro_seen"):
		finish_intro()
	else:
		skip_dialog.popup_centered(Vector2i(370,110))

func finish_intro() -> void:
	# All completion paths converge here; idempotent under repeated skip/Enter.
	if completed:
		return
	completed = true
	handoff_count += 1
	if fade != null:
		fade.kill()
	skip_dialog.hide()
	GameState.set_flag("opening_intro_seen")
	GameState.set_flag("entered_tsukimori")
	overlay.hide()
	dialogue.hide()
	weather.active = true
	weather.show()
	heading.text = "Tsukimori  /  村"
	heading.show()
	hint.text = words.controls
	hint.show()
	ambience.leave_vehicle()
	street.enable_control()
	handoff_completed.emit()
	print("OPENING_HANDOFF: opening_intro_seen=true entered_tsukimori=true input_enabled=true")

func update_ambient(delta: float) -> void:
	bubble_time = maxf(0,bubble_time-delta)
	if bubble_time <= 0:
		bubble.hide()
	else:
		position_bubble()
	var p: Vector2 = street.player.position
	if p.x > 712:
		show_bubble(words.end,p)
	elif Input.is_action_just_pressed("observe"):
		for resident in street.residents:
			if p.distance_to(resident.position) < 85 and not resident.phrase.is_empty():
				show_bubble(resident.phrase,resident.position)
				break
	else:
		for resident in street.residents:
			if resident.look_time > 1.9 and not resident.phrase.is_empty() and not shown_phrases.has(resident.name) and bubble_time <= 0:
				shown_phrases[resident.name] = true
				show_bubble(resident.phrase,resident.position)
				break

func show_bubble(text: String, at: Vector2) -> void:
	bubble.text = text
	bubble_time = 3.7
	bubble_anchor = at
	position_bubble()
	bubble.show()

func position_bubble() -> void:
	var screen_at: Vector2 = street.get_viewport().get_canvas_transform() * bubble_anchor
	bubble.position = Vector2(clampf(screen_at.x-125,8,382),clampf(screen_at.y-145,8,300))

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE and not skip_dialog.visible:
			request_skip()
		elif event.keycode in [KEY_ENTER,KEY_SPACE]:
			advance_line()
		elif event.keycode == KEY_F1 and completed:
			help_visible = not help_visible
			hint.visible = help_visible
