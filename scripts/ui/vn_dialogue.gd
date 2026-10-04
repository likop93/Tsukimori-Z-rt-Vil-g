extends CanvasLayer
signal finished
signal choice_selected(id: String)
signal line_shown(index: int)
var choices: Array = []
var choice_box: VBoxContainer
var active := false
var lines: Array = []
var index := 0
var revealed := 0.0
var root: Control
var body: Label
var speaker: Label
var nameplate: Panel
var portrait: TextureRect
var prompt: Label
var next_button: Button
var portrait_speaker := "Miyako"

func _ready() -> void:
	layer = 30
	root = Control.new()
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(root)
	portrait = TextureRect.new()
	portrait.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	# REVIEW transparent cutout based on the approved Primary Design A.
	# Characters sit directly over the world, behind the dialogue panel.
	portrait.texture = preload("res://assets/opening/vn_portraits/miyako_cutout_v1_REVIEW.png")
	portrait.position = Vector2(404,18)
	portrait.size = Vector2(228,342)
	portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	portrait.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	portrait.mouse_filter = Control.MOUSE_FILTER_IGNORE
	root.add_child(portrait)
	portrait.set_deferred("size",Vector2(228,342))
	panel(Vector2(24,250),Vector2(592,98))
	nameplate = panel(Vector2(24,224),Vector2(170,27))
	speaker = text_at(Vector2(38,226),Vector2(145,23),17)
	speaker.add_theme_color_override("font_color",Color("#e8b38c"))
	body = text_at(Vector2(40,260),Vector2(560,62),16)
	body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	prompt = text_at(Vector2(40,326),Vector2(450,18),10)
	prompt.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	next_button = Button.new()
	next_button.position = Vector2(504,322)
	next_button.size = Vector2(96,24)
	next_button.add_theme_font_size_override("font_size",12)
	next_button.pressed.connect(advance)
	root.add_child(next_button)
	choice_box = VBoxContainer.new()
	choice_box.position = Vector2(24,124)
	choice_box.size = Vector2(410,100)
	choice_box.add_theme_constant_override("separation",8)
	root.add_child(choice_box)
	choice_box.hide()
	root.hide()

func panel(at: Vector2, dimensions: Vector2) -> Panel:
	var item := Panel.new()
	item.position = at
	item.size = dimensions
	item.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.035,0.025,0.05,0.96)
	style.border_color = Color("#a46170")
	style.set_border_width_all(1)
	item.add_theme_stylebox_override("panel",style)
	root.add_child(item)
	return item

func text_at(at: Vector2, dimensions: Vector2, font_size: int) -> Label:
	var item := Label.new()
	item.position = at
	item.size = dimensions
	item.add_theme_font_size_override("font_size",font_size)
	item.add_theme_color_override("font_color",Color("#f0e6dd"))
	item.mouse_filter = Control.MOUSE_FILTER_IGNORE
	root.add_child(item)
	return item

func begin(data: Dictionary) -> void:
	if active:
		return
	lines = data.lines
	choices = data.get("choices",[])
	portrait.visible = bool(data.get("portrait",true))
	portrait_speaker = str(data.get("portrait_speaker","Miyako"))
	portrait.texture = load(str(data.get("portrait_path","res://assets/opening/vn_portraits/miyako_cutout_v1_REVIEW.png")))
	index = 0
	active = true
	root.show()
	show_line()

func show_line() -> void:
	speaker.text = str(lines[index].speaker)
	nameplate.visible = not speaker.text.is_empty()
	portrait.modulate = Color.WHITE if speaker.text == portrait_speaker else Color(0.65,0.65,0.7)
	body.text = str(lines[index].text)
	body.visible_characters = 0
	revealed = 0
	update_prompt()
	line_shown.emit(index)

func update_prompt() -> void:
	if choice_box != null and choice_box.visible:
		next_button.hide()
		return
	var ending := "Válasz" if not choices.is_empty() else "Befejezés"
	var action := "Kiírás" if body.visible_characters < body.get_total_character_count() else (ending if index == lines.size()-1 else "Tovább")
	next_button.text = action
	next_button.show()
	prompt.text = "E / Space / Enter · tovább"

func _process(delta: float) -> void:
	if not active:
		return
	revealed += delta*36
	body.visible_characters = mini(int(revealed),body.get_total_character_count())
	update_prompt()

func advance() -> void:
	if not active or choice_box.visible:
		return
	if body.visible_characters < body.get_total_character_count():
		revealed = body.get_total_character_count()
		body.visible_characters = body.get_total_character_count()
		update_prompt()
		return
	if index < lines.size()-1:
		index += 1
		show_line()
	elif not choices.is_empty():
		show_choices()
	else:
		active = false
		root.hide()
		finished.emit()

func show_choices() -> void:
	choice_box.show()
	next_button.hide()
	prompt.text = "Nyilak + Enter / kattintás · választás"
	for option in choices:
		var button := Button.new()
		button.text = str(option.label)
		button.custom_minimum_size = Vector2(410,42)
		button.add_theme_font_size_override("font_size",13)
		var style := StyleBoxFlat.new()
		style.bg_color = Color(0.045,0.025,0.05,0.96)
		style.border_color = Color("#a46170")
		style.set_border_width_all(1)
		button.add_theme_stylebox_override("normal",style)
		var selected := style.duplicate() as StyleBoxFlat
		selected.bg_color = Color("#372333")
		selected.border_color = Color("#e8b38c")
		button.add_theme_stylebox_override("hover",selected)
		button.add_theme_stylebox_override("focus",selected)
		button.pressed.connect(select_choice.bind(option))
		choice_box.add_child(button)
	choice_box.get_child(0).grab_focus()

func select_choice(option: Dictionary) -> void:
	if not choice_box.visible:
		return
	choice_box.hide()
	for button in choice_box.get_children():
		choice_box.remove_child(button)
		button.queue_free()
	choices = []
	lines = option.lines
	index = 0
	choice_selected.emit(str(option.id))
	show_line()

func _input(event: InputEvent) -> void:
	if not active or choice_box.visible:
		return
	var key: bool = event is InputEventKey and event.pressed and not event.echo and event.keycode in [KEY_E,KEY_SPACE,KEY_ENTER]
	var click: bool = event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT
	if click and get_viewport().gui_get_hovered_control() is Button:
		return # Menu and dialogue buttons handle their own click.
	if click and next_button.get_global_rect().has_point(next_button.get_global_mouse_position()):
		return # The actual button handles this click, once.
	if key or click:
		advance()
		get_viewport().set_input_as_handled()
