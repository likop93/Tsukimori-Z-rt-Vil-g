extends Control
const OPENING := "res://scenes/opening/opening.tscn"
var start_button: Button
var settings_button: Button
var controls_button: Button
var quit_button: Button
var modal: Panel
var modal_shade: ColorRect
var slider: HSlider
var fullscreen: CheckButton
var volume_label: Label
var back_button: Button
var fade: ColorRect
var buttons: Array[Button] = []
var starting := false
var settings_open := false
var return_focus: Button

func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var art := TextureRect.new()
	art.texture = preload("res://assets/opening/short_intro_v1/forest_gate_REVIEW.png")
	art.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	art.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	art.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	art.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	art.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(art)
	var weather := preload("res://scripts/opening/weather.gd").new()
	weather.modulate.a = 0.55
	add_child(weather)
	var shade := ColorRect.new()
	shade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	shade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var shader := Shader.new()
	shader.code = "shader_type canvas_item; void fragment(){ COLOR=vec4(0.016,0.025,0.045,mix(0.94,0.12,smoothstep(0.20,0.92,UV.x))); }"
	var material := ShaderMaterial.new()
	material.shader = shader
	shade.material = material
	add_child(shade)
	label(self,"TSUKIMORI",Vector2(38,48),Vector2(350,50),36,Color("#eed8b6"))
	label(self,"Z Á R T  V I L Á G",Vector2(41,103),Vector2(280,24),14,Color("#bf9a76"))
	var line := ColorRect.new()
	line.position = Vector2(41,140)
	line.size = Vector2(205,1)
	line.color = Color("#725346")
	line.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(line)
	start_button = button(self,"Játék indítása",Vector2(40,165),Vector2(220,32),start_game)
	settings_button = button(self,"Beállítások",Vector2(40,204),Vector2(220,32),open_settings)
	controls_button = button(self,"Irányítás",Vector2(40,243),Vector2(220,32),open_controls)
	quit_button = button(self,"Kilépés",Vector2(40,282),Vector2(220,32),quit_game)
	buttons = [start_button,settings_button,controls_button,quit_button]
	label(self,"Nyilak · választás     Enter · megnyitás",Vector2(40,333),Vector2(340,17),10,Color("#a3a3b1"))
	start_button.grab_focus()
	var ambience := preload("res://scripts/opening/ambience.gd").new()
	add_child(ambience)
	ambience.vehicle.stop()
	ambience.rain.volume_db = -24
	fade = ColorRect.new()
	fade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	fade.color = Color(0,0,0,0)
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fade.z_index = 100
	add_child(fade)

func label(parent: Node, text: String, at: Vector2, dimensions: Vector2, font_size: int, color := Color("#f0e5d4")) -> Label:
	var item := Label.new()
	item.text = text
	item.position = at
	item.size = dimensions
	item.add_theme_font_size_override("font_size",font_size)
	item.add_theme_color_override("font_color",color)
	item.mouse_filter = Control.MOUSE_FILTER_IGNORE
	parent.add_child(item)
	return item

func style(color: Color, border: Color) -> StyleBoxFlat:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.border_color = border
	box.set_border_width_all(1)
	box.content_margin_left = 12
	box.content_margin_right = 12
	return box

func button(parent: Node, text: String, at: Vector2, dimensions: Vector2, action: Callable) -> Button:
	var item := Button.new()
	item.text = text
	item.position = at
	item.size = dimensions
	item.alignment = HORIZONTAL_ALIGNMENT_LEFT
	item.add_theme_font_size_override("font_size",15)
	item.add_theme_color_override("font_color",Color("#eadaca"))
	item.add_theme_stylebox_override("normal",style(Color(0.04,0.055,0.08,0.65),Color("#57444c")))
	item.add_theme_stylebox_override("hover",style(Color("#2e2430"),Color("#c89966")))
	item.add_theme_stylebox_override("pressed",style(Color("#493040"),Color("#ebc291")))
	item.add_theme_stylebox_override("focus",style(Color(0,0,0,0),Color("#e9ba7c")))
	item.pressed.connect(action)
	parent.add_child(item)
	return item

func prepare_modal(title: String, origin: Button) -> void:
	if is_instance_valid(modal):
		return
	return_focus = origin
	for item in buttons:
		item.disabled = true
	modal_shade = ColorRect.new()
	modal_shade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	modal_shade.color = Color(0,0,0,0.7)
	add_child(modal_shade)
	modal = Panel.new()
	modal.position = Vector2(70,54)
	modal.size = Vector2(500,260)
	modal.add_theme_stylebox_override("panel",style(Color("#111827"),Color("#b38c67")))
	add_child(modal)
	label(modal,title,Vector2(26,20),Vector2(448,34),23)
	back_button = button(modal,"Vissza",Vector2(26,209),Vector2(150,32),close_modal)

func open_settings() -> void:
	if starting or is_instance_valid(modal):
		return
	prepare_modal("Beállítások",settings_button)
	settings_open = true
	volume_label = label(modal,"",Vector2(26,72),Vector2(440,24),15)
	slider = HSlider.new()
	slider.position = Vector2(26,109)
	slider.size = Vector2(448,24)
	slider.min_value = 0
	slider.max_value = 100
	slider.step = 5
	slider.value = AppSettings.volume*100
	slider.value_changed.connect(volume_changed)
	modal.add_child(slider)
	volume_changed(slider.value)
	fullscreen = CheckButton.new()
	fullscreen.text = "Teljes képernyő"
	fullscreen.position = Vector2(26,152)
	fullscreen.size = Vector2(448,32)
	fullscreen.add_theme_font_size_override("font_size",15)
	fullscreen.button_pressed = AppSettings.fullscreen
	fullscreen.toggled.connect(AppSettings.set_fullscreen)
	modal.add_child(fullscreen)
	slider.grab_focus()

func volume_changed(value: float) -> void:
	AppSettings.set_volume(value/100)
	volume_label.text = "Hangerő · "+str(roundi(value))+"%"

func open_controls() -> void:
	if starting or is_instance_valid(modal):
		return
	prepare_modal("Irányítás",controls_button)
	label(modal,"WASD / nyilak     Séta\nE                           Figyelés / beszélgetés / tovább\nSpace / Enter        A nyitó szöveg gyorsítása\nEsc                        A nyitás kihagyása\nF1                          Segítség megjelenítése",Vector2(26,69),Vector2(448,127),14)
	back_button.grab_focus()

func close_modal() -> void:
	if not is_instance_valid(modal):
		return
	if settings_open:
		var error := AppSettings.save_settings()
		if error != OK:
			volume_label.text = "A beállítások mentése nem sikerült."
			return
	settings_open = false
	remove_child(modal)
	remove_child(modal_shade)
	modal.queue_free()
	modal_shade.queue_free()
	modal = null
	for item in buttons:
		item.disabled = false
	return_focus.grab_focus()

func start_game() -> void:
	if starting or is_instance_valid(modal):
		return
	starting = true
	for item in buttons:
		item.disabled = true
	GameState.clear_runtime_state()
	var transition := create_tween()
	transition.tween_property(fade,"color:a",1.0,0.35)
	transition.tween_callback(func() -> void: get_tree().change_scene_to_file(OPENING))

func quit_game() -> void:
	if not starting and not is_instance_valid(modal):
		get_tree().quit()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and is_instance_valid(modal):
		close_modal()
		get_viewport().set_input_as_handled()
