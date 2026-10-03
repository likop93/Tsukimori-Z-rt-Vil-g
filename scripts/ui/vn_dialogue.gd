extends CanvasLayer
signal finished
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
	prompt = text_at(Vector2(40,326),Vector2(558,18),10)
	prompt.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
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
	index = 0
	active = true
	root.show()
	show_line()

func show_line() -> void:
	speaker.text = str(lines[index].speaker)
	nameplate.visible = not speaker.text.is_empty()
	portrait.modulate = Color.WHITE if nameplate.visible else Color(0.65,0.65,0.7)
	body.text = str(lines[index].text)
	body.visible_characters = 0
	revealed = 0
	update_prompt()

func update_prompt() -> void:
	var action := "Kiírás" if body.visible_characters < body.get_total_character_count() else ("Befejezés" if index == lines.size()-1 else "Tovább")
	prompt.text = "E / Space / Enter / kattintás · "+action

func _process(delta: float) -> void:
	if not active:
		return
	revealed += delta*36
	body.visible_characters = mini(int(revealed),body.get_total_character_count())
	update_prompt()

func advance() -> void:
	if not active:
		return
	if body.visible_characters < body.get_total_character_count():
		revealed = body.get_total_character_count()
		body.visible_characters = body.get_total_character_count()
		update_prompt()
		return
	if index < lines.size()-1:
		index += 1
		show_line()
	else:
		active = false
		root.hide()
		finished.emit()

func _input(event: InputEvent) -> void:
	if not active:
		return
	var key: bool = event is InputEventKey and event.pressed and not event.echo and event.keycode in [KEY_E,KEY_SPACE,KEY_ENTER]
	var click: bool = event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT
	if key or click:
		advance()
		get_viewport().set_input_as_handled()
