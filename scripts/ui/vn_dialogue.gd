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
var akira_portrait: TextureRect
var prompt: Label
var next_button: Button
var portrait_speaker := "Miyako"
var portrait_variants: Dictionary = {}
var portrait_trim := false
var portrait_source_path := ""
var portraits_enabled := true
var akira_enabled := true
var cg: TextureRect
var cg_path := ""
var dialogue_panel: Panel
var dialogue_id := ""

func _ready() -> void:
	layer = 30
	root = Control.new()
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(root)
	cg = TextureRect.new()
	cg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	cg.size = Vector2(640,360)
	cg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	cg.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	cg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	cg.hide()
	root.add_child(cg)
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
	akira_portrait = TextureRect.new()
	akira_portrait.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	akira_portrait.position = Vector2(404,48)
	akira_portrait.size = Vector2(228,312)
	akira_portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	akira_portrait.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	akira_portrait.mouse_filter = Control.MOUSE_FILTER_IGNORE
	root.add_child(akira_portrait)
	dialogue_panel = panel(Vector2(24,232),Vector2(592,116))
	nameplate = panel(Vector2(24,206),Vector2(170,27))
	speaker = text_at(Vector2(50,208),Vector2(138,23),17)
	speaker.add_theme_color_override("font_color",Color("#e8b38c"))
	body = text_at(Vector2(40,242),Vector2(560,76),16)
	body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	prompt = text_at(Vector2(40,326),Vector2(450,18),10)
	prompt.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	prompt.add_theme_color_override("font_color",Color("#bfa8a4"))
	next_button = Button.new()
	next_button.position = Vector2(504,322)
	next_button.size = Vector2(96,24)
	next_button.add_theme_font_size_override("font_size",12)
	style_button(next_button)
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
	style.bg_color = Color(0.04,0.025,0.045,0.94)
	style.border_color = Color("#89515e")
	style.set_border_width_all(1)
	style.shadow_color = Color(0,0,0,0.45)
	style.shadow_size = 4
	item.add_theme_stylebox_override("panel",style)
	root.add_child(item)
	var ornament := Control.new()
	ornament.set_script(preload("res://scripts/ui/vn_frame.gd"))
	item.add_child(ornament)
	ornament.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	return item

func style_button(button: Button) -> void:
	for state in ["normal","hover","pressed","focus"]:
		var style := StyleBoxFlat.new()
		style.bg_color = Color("#211823") if state == "normal" else Color("#48303c")
		style.border_color = Color("#8e5d67") if state == "normal" else Color("#e4ba87")
		style.set_border_width_all(1)
		style.border_width_left = 3
		style.set_content_margin_all(3)
		if state == "focus":
			style.bg_color = Color.TRANSPARENT
		button.add_theme_stylebox_override(state,style)
	button.add_theme_color_override("font_color",Color("#efdfcc"))
	button.add_theme_color_override("font_hover_color",Color("#fff2da"))
	button.add_theme_color_override("font_focus_color",Color("#fff2da"))

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
	dialogue_id = str(data.get("id",""))
	choices = data.get("choices",[])
	portraits_enabled = bool(data.get("portrait",true))
	akira_enabled = bool(data.get("akira_portrait",true))
	akira_portrait.texture = load(str(data.get("akira_portrait_path","res://assets/opening/vn_portraits/akira_neutral_v1_REVIEW.png"))) if portraits_enabled and akira_enabled else null
	cg_path = ""
	# Stable two-character staging; partner stays left, Akira stays right.
	var partner_left := str(data.get("portrait_side","left")) == "left"
	portrait.position = Vector2(8 if partner_left else 404,48)
	akira_portrait.position = Vector2(404 if partner_left else 8,48)
	portrait.flip_h = partner_left if str(data.get("portrait_facing","left")) == "left" else not partner_left
	akira_portrait.flip_h = not partner_left if str(data.get("akira_facing","left")) == "left" else partner_left
	portrait.size = Vector2(228,312)
	if data.get("portrait_trim",false):
		# Seated clinic patients share the doctor's eyeline, with a lower body frame.
		portrait.position += Vector2(10 if partner_left else -10,20)
		portrait.size = Vector2(208,292)
	portrait_trim = bool(data.get("portrait_trim",false))
	portrait_speaker = str(data.get("portrait_speaker","Miyako"))
	portrait_variants = data.get("portrait_variants",{})
	portrait_source_path = ""
	set_partner_texture(str(data.get("portrait_path","res://assets/opening/vn_portraits/miyako_cutout_v1_REVIEW.png")))
	index = 0
	active = true
	root.show()
	show_line()

func show_line() -> void:
	if lines[index].has("cg"):
		cg_path = str(lines[index].cg)
		cg.texture = load(cg_path) if not cg_path.is_empty() else null
		var zoom := float(lines[index].get("cg_zoom",1.0))
		cg.size = Vector2(640,360)*zoom
		cg.position = (Vector2(640,360)-cg.size)*Vector2(0.5,1.0)
	cg.visible = not cg_path.is_empty()
	portrait.visible = portraits_enabled and not cg.visible
	akira_portrait.visible = portraits_enabled and akira_enabled and not cg.visible
	var expression := str(lines[index].get("expression",""))
	if portrait_variants.has(expression):
		set_partner_texture(str(portrait_variants[expression]))
	speaker.text = str(lines[index].speaker)
	nameplate.visible = not speaker.text.is_empty()
	portrait.modulate = Color.WHITE if speaker.text == portrait_speaker else Color(0.65,0.65,0.7)
	akira_portrait.modulate = Color.WHITE if speaker.text == "Akira" else Color(0.65,0.65,0.7)
	body.text = str(lines[index].text)
	set_story_layout(cg.visible)
	body.visible_characters = 0
	revealed = 0
	update_prompt()
	line_shown.emit(index)

func set_story_layout(story_image: bool) -> void:
	# CG captions leave the character gesture and collarbone mark visible.
	# Three shorter lines still fit, with a separate bottom row for controls.
	dialogue_panel.position.y = 264 if story_image else 232
	dialogue_panel.size.y = 92 if story_image else 116
	body.add_theme_font_size_override("font_size",13 if story_image else 16)
	body.position.y = 272 if story_image else 242
	body.size.y = 54 if story_image else 76
	nameplate.position.y = 238 if story_image else 206
	speaker.position.y = 240 if story_image else 208
	next_button.position.y = 332 if story_image else 322
	prompt.position.y = 336 if story_image else 326

func set_partner_texture(path: String) -> void:
	if path == portrait_source_path:
		return
	portrait_source_path = path
	var source := load(path) as Texture2D
	if portrait_trim and source != null:
		# Legacy portraits have different transparent margins. Trim at display
		# time so the head and body fit the same VN stage; keep source PNGs intact.
		var framed := AtlasTexture.new()
		framed.atlas = source
		framed.region = source.get_image().get_used_rect()
		portrait.texture = framed
	else:
		portrait.texture = source

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
		style_button(button)
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
	lines = option.lines.duplicate(true)
	if GameState.record_distance(dialogue_id,str(option.id)):
		lines.append({"speaker":"","text":GameState.horror_response()})
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
