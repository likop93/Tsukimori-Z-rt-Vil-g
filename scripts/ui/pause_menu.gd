extends CanvasLayer
var runner: Node
var root: Control
var panel: Panel
var body: Control
var menu_button: Button
var resume_button: Button
var volume_label: Label
var slider: HSlider
var fullscreen: CheckButton
var confirmation: ConfirmationDialog
var previous_focus: Control
var page := "main"
var journal_entries: Array[Dictionary] = []
var selected_character := 0

func _ready() -> void:
	layer = 80
	process_mode = Node.PROCESS_MODE_ALWAYS
	menu_button = make_button(self,"Menü",Vector2(555,16),Vector2(65,26),open_menu)
	root = Control.new()
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(root)
	var shade := ColorRect.new()
	shade.color = Color(0.01,0.015,0.03,0.78)
	shade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root.add_child(shade)
	panel = Panel.new()
	panel.position = Vector2(140,34)
	panel.size = Vector2(360,292)
	panel.add_theme_stylebox_override("panel",box(Color("#111827")))
	root.add_child(panel)
	confirmation = ConfirmationDialog.new()
	confirmation.title = "Vissza a főmenübe"
	confirmation.dialog_text = "Visszatérsz a főmenübe? A jelenlegi előrehaladás elvész."
	confirmation.ok_button_text = "Főmenü"
	confirmation.cancel_button_text = "Maradok"
	confirmation.confirmed.connect(return_to_main)
	root.add_child(confirmation)
	root.hide()
	show_main()

func box(color: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.border_color = Color("#b38c67")
	style.set_border_width_all(1)
	return style

func make_button(parent: Node, text: String, at: Vector2, size: Vector2, action: Callable) -> Button:
	var button := Button.new()
	button.text = text
	button.position = at
	button.size = size
	button.add_theme_font_size_override("font_size",15)
	button.add_theme_stylebox_override("normal",box(Color("#1a202d")))
	button.add_theme_stylebox_override("hover",box(Color("#493040")))
	button.add_theme_stylebox_override("focus",box(Color("#372333")))
	button.pressed.connect(action)
	parent.add_child(button)
	return button

func label(text: String, at: Vector2, size: Vector2, font_size := 16) -> Label:
	var item := Label.new()
	item.text = text
	item.position = at
	item.size = size
	item.add_theme_font_size_override("font_size",font_size)
	item.add_theme_color_override("font_color",Color("#eadaca"))
	item.mouse_filter = Control.MOUSE_FILTER_IGNORE
	body.add_child(item)
	return item

func clear_page(title: String) -> void:
	panel.position = Vector2(140,34)
	panel.size = Vector2(360,292)
	if is_instance_valid(body):
		panel.remove_child(body)
		body.queue_free()
	body = Control.new()
	body.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	panel.add_child(body)
	label(title,Vector2(24,18),Vector2(312,34),24)

func show_main() -> void:
	page = "main"
	clear_page("Szünet")
	resume_button = make_button(body,"Folytatás",Vector2(24,64),Vector2(312,32),resume)
	make_button(body,"Karakterek",Vector2(24,101),Vector2(312,32),show_characters)
	make_button(body,"Beállítások",Vector2(24,138),Vector2(312,32),show_settings)
	make_button(body,"Irányítás",Vector2(24,175),Vector2(312,32),show_controls)
	make_button(body,"Főmenü",Vector2(24,212),Vector2(312,32),func(): confirmation.popup_centered(Vector2i(410,120)))
	label("Esc / Tab · folytatás",Vector2(24,257),Vector2(312,18),12)
	if root.visible:
		resume_button.grab_focus()

func open_menu() -> void:
	if root.visible or runner.skip_dialog.visible:
		return
	previous_focus = get_viewport().gui_get_focus_owner()
	get_tree().paused = true
	root.show()
	menu_button.hide()
	show_main()
	get_viewport().set_input_as_handled()

func resume() -> void:
	root.hide()
	menu_button.show()
	get_tree().paused = false
	get_viewport().set_input_as_handled()
	if is_instance_valid(previous_focus) and previous_focus != menu_button and previous_focus.is_visible_in_tree():
		previous_focus.grab_focus()
	else:
		get_viewport().gui_release_focus()

func show_settings() -> void:
	page = "settings"
	clear_page("Beállítások")
	volume_label = label("Hangerő · "+str(roundi(AppSettings.volume*100))+"%",Vector2(24,74),Vector2(312,25))
	slider = HSlider.new()
	slider.position = Vector2(24,111)
	slider.size = Vector2(312,26)
	slider.max_value = 100
	slider.step = 5
	slider.value = AppSettings.volume*100
	slider.value_changed.connect(func(value: float):
		AppSettings.set_volume(value/100)
		volume_label.text = "Hangerő · "+str(roundi(value))+"%")
	body.add_child(slider)
	fullscreen = CheckButton.new()
	fullscreen.text = "Teljes képernyő"
	fullscreen.position = Vector2(24,156)
	fullscreen.button_pressed = AppSettings.fullscreen
	fullscreen.toggled.connect(AppSettings.set_fullscreen)
	body.add_child(fullscreen)
	make_button(body,"Vissza",Vector2(24,229),Vector2(312,36),back)
	slider.grab_focus()

func show_controls() -> void:
	page = "controls"
	clear_page("Irányítás")
	label("WASD / nyilak · séta\nShift nyomva · futás\nE · figyelés / beszélgetés / tovább\nSpace / Enter · szöveg\nEsc · szünet (intróban kihagyás)\nTab / Menü · szünet bármikor\nF1 · segítség",Vector2(24,68),Vector2(312,150),14)
	make_button(body,"Vissza",Vector2(24,229),Vector2(312,36),back).grab_focus()

func show_characters() -> void:
	journal_entries = preload("res://scripts/ui/character_journal.gd").entries()
	selected_character = clampi(selected_character,0,journal_entries.size()-1)
	show_character(selected_character)

func show_character(index: int) -> void:
	selected_character = index
	page = "characters"
	clear_page("Karakterek")
	panel.position = Vector2(24,16)
	panel.size = Vector2(592,328)
	var selected_button: Button
	for i in journal_entries.size():
		var entry: Dictionary = journal_entries[i]
		var button := make_button(body,str(entry.title),Vector2(16,62+i*38),Vector2(158,32),show_character.bind(i))
		button.add_theme_font_size_override("font_size",13)
		if i == index:
			selected_button = button
	var entry: Dictionary = journal_entries[index]
	if entry.known:
		var portrait := TextureRect.new()
		var texture: Texture2D = load(entry.portrait)
		if entry.has("crop"):
			var c: Array = entry.crop
			var crop := AtlasTexture.new()
			crop.atlas = texture
			crop.region = Rect2(Vector2(c[0],c[1])*texture.get_size(),Vector2(c[2],c[3])*texture.get_size())
			texture = crop
		portrait.texture = texture
		portrait.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		portrait.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		portrait.position = Vector2(183,58)
		portrait.size = Vector2(146,244)
		portrait.mouse_filter = Control.MOUSE_FILTER_IGNORE
		body.add_child(portrait)
		if str(entry.id) == "hana" and int(entry.get("reaction_stage",0)) == 2:
			portrait.size.y = 216
			var wardrobe := make_button(body,"Hétköznapi",Vector2(183,282),Vector2(146,28),func(): pass)
			wardrobe.name = "HanaWardrobePreview"
			wardrobe.toggle_mode = true
			wardrobe.add_theme_font_size_override("font_size",12)
			wardrobe.toggled.connect(func(casual: bool):
				portrait.texture = load("res://assets/opening/vn_portraits/hana_casual_deferential_v1_REVIEW.png" if casual else str(entry.portrait))
				wardrobe.text = "Kimonó" if casual else "Hétköznapi"
			)
	else:
		label("?",Vector2(225,113),Vector2(80,100),64)
	label(str(entry.title),Vector2(344,60),Vector2(232,26),19)
	var scroll := ScrollContainer.new()
	scroll.position = Vector2(344,95)
	scroll.size = Vector2(232,217)
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	body.add_child(scroll)
	var details := VBoxContainer.new()
	details.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	details.add_theme_constant_override("separation",12)
	scroll.add_child(details)
	var sections: Array = [str(entry.description),"Kapcsolati státusz",str(entry.status)]
	if entry.has("reaction_label"):
		sections.append("Jelenlegi viselkedés · "+str(entry.reaction_label))
		sections.append(str(entry.reaction_description))
	sections.append("\n".join(entry.events))
	for text in sections:
		var item := Label.new()
		item.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		item.text = text
		item.custom_minimum_size.x = 210
		item.add_theme_font_size_override("font_size",13)
		details.add_child(item)
	make_button(body,"Vissza",Vector2(16,280),Vector2(158,32),back)
	selected_button.grab_focus()

func back() -> void:
	if page == "settings" and AppSettings.save_settings() != OK:
		volume_label.text = "A beállítások mentése nem sikerült."
		return
	show_main()

func return_to_main() -> void:
	get_tree().paused = false
	get_viewport().set_input_as_handled()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if root.visible and event.keycode == KEY_SPACE:
			# Dialogue's habitual Space press must not activate Resume.
			get_viewport().set_input_as_handled()
			return
		if confirmation.visible:
			return
		if event.keycode == KEY_TAB or (event.keycode == KEY_ESCAPE and (root.visible or runner.completed)):
			get_viewport().set_input_as_handled()
			if not root.visible:
				open_menu()
			elif page != "main":
				back()
			else:
				resume()
