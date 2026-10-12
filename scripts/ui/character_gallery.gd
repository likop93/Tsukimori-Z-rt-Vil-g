extends Control
# Development previews never grant meetings, affinity, costumes or horror events.
var profiles: Array = []
var selected := 0
var casual := true
var page: Control
var portrait: TextureRect
var description: Label
var variant_button: Button
var sample_button: Button
var character_buttons: Array[Button] = []
var vn: CanvasLayer

func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	profiles = JSON.parse_string(FileAccess.get_file_as_string("res://data/ui/character_development.json")).characters
	var background := ColorRect.new()
	background.color = Color("#12121d")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)
	var note := Label.new()
	note.text = "Karaktertervek · jelenetpróba · nem módosítja a történetet"
	note.position = Vector2(20,6)
	note.add_theme_font_size_override("font_size",11)
	add_child(note)
	page = Control.new()
	page.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(page)
	for i in profiles.size():
		character_buttons.append(make_button(str(profiles[i].name),Vector2(20+i*96,28),Vector2(90,28),select_character.bind(i)))
	portrait = TextureRect.new()
	portrait.position = Vector2(28,64)
	portrait.size = Vector2(240,250)
	portrait.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	portrait.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	portrait.mouse_filter = Control.MOUSE_FILTER_IGNORE
	page.add_child(portrait)
	var scroll := ScrollContainer.new()
	scroll.position = Vector2(292,64)
	scroll.size = Vector2(326,238)
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	page.add_child(scroll)
	description = Label.new()
	description.custom_minimum_size.x = 305
	description.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	description.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	description.add_theme_font_size_override("font_size",13)
	scroll.add_child(description)
	make_button("Főmenü",Vector2(20,322),Vector2(110,28),return_to_main)
	variant_button = make_button("Alapruha",Vector2(138,322),Vector2(140,28),toggle_outfit)
	sample_button = make_button("Beszélgetéspróba",Vector2(380,322),Vector2(238,28),start_sample)
	select_character(0)

func make_button(title: String, at: Vector2, dimensions: Vector2, action: Callable) -> Button:
	var button := Button.new()
	button.text = title
	button.position = at
	button.size = dimensions
	button.add_theme_font_size_override("font_size",13)
	for state in ["normal","hover","pressed","focus"]:
		var border := StyleBoxFlat.new()
		border.bg_color = Color("#221b29") if state == "normal" else Color("#3c2b3e")
		border.border_color = Color("#78535e") if state == "normal" else Color("#d6b08a")
		border.set_border_width_all(1)
		if state == "focus":
			border.bg_color = Color.TRANSPARENT
		button.add_theme_stylebox_override(state,border)
	button.add_theme_color_override("font_color",Color("#efdfcc"))
	button.pressed.connect(action)
	page.add_child(button)
	return button

func select_character(index: int) -> void:
	selected = index
	refresh()
	(description.get_parent() as ScrollContainer).scroll_vertical = 0
	character_buttons[index].grab_focus()

func refresh() -> void:
	var spec: Dictionary = profiles[selected]
	portrait.texture = load(str(spec.casual if casual else spec.portrait))
	variant_button.text = "Alapruha" if casual else "Hétköznapi ruha"
	description.text = str(spec.name)+" · "+str(spec.tagline)+"\n\n"+str(spec.essence)+"\n\nKözeledés\n"+str(spec.trust)+"\n\nRuhatár\n"+str(spec.wardrobe)+"\n\nLassú változás · terv\n"+"\n\n".join(spec.stages)+"\n\n"+str(spec.scene)

func toggle_outfit() -> void:
	casual = not casual
	refresh()

func start_sample() -> void:
	if is_instance_valid(vn):
		return
	var spec: Dictionary = profiles[selected]
	page.hide()
	vn = preload("res://scripts/ui/vn_dialogue.gd").new()
	add_child(vn)
	vn.finished.connect(close_sample)
	vn.begin({"id":"gallery_"+str(spec.id),"preview_mode":true,"portrait_speaker":spec.name,
		"portrait_path":spec.casual if casual else spec.portrait,"portrait_side":"left",
		"lines":spec.lines.duplicate(true),"choices":spec.choices.duplicate(true)})

func close_sample() -> void:
	if is_instance_valid(vn):
		vn.queue_free()
		vn = null
	page.show()
	sample_button.grab_focus()

func return_to_main() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		if is_instance_valid(vn):
			close_sample()
		else:
			return_to_main()
