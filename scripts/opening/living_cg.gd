extends CanvasLayer
## One still image, camera move and separate atmospheric effects. No character warp.
signal handoff_requested
signal completed
const DURATION := 9.0
const FADE_OUT := 0.8
var elapsed := 0.0
var started := false
var transitioning := false
var ended := false
var transition_elapsed := 0.0
var transition_start_alpha := 1.0
var root: Control
var camera_stage: Node2D
var picture: Sprite2D
var effects: Control
var skip_button: Button
var original_scale_mode: int
var owns_scale_mode := false

func begin(texture: Texture2D, lamp_positions: Array = []) -> bool:
	if started or texture == null:
		return false
	var ratio := float(texture.get_width()) / float(texture.get_height())
	if texture.get_width() < 1280 or absf(ratio - 16.0/9.0) > 0.02:
		return false
	started = true
	layer = 35 # Crossfade above the existing VN layer, below the pause menu.
	process_mode = Node.PROCESS_MODE_PAUSABLE
	original_scale_mode = get_window().content_scale_mode
	get_window().content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
	owns_scale_mode = true
	root = Control.new()
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(root)
	camera_stage = Node2D.new()
	root.add_child(camera_stage)
	picture = Sprite2D.new()
	picture.texture = texture
	picture.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	picture.position = Vector2(320,180)
	picture.scale = Vector2.ONE * maxf(640.0/texture.get_width(),360.0/texture.get_height())
	camera_stage.add_child(picture)
	effects = preload("res://scripts/opening/living_cg_effects.gd").new()
	effects.size = Vector2(640,360)
	effects.z_index = 1
	effects.lamp_positions = lamp_positions.duplicate(true)
	camera_stage.add_child(effects)
	skip_button = Button.new()
	skip_button.text = "Átvezető kihagyása"
	skip_button.position = Vector2(420,322)
	skip_button.size = Vector2(196,26)
	skip_button.add_theme_font_size_override("font_size",13)
	skip_button.pressed.connect(skip)
	root.add_child(skip_button)
	update_stage()
	return true

func update_stage() -> void:
	var progress := clampf(elapsed / DURATION,0.0,1.0)
	var zoom := 1.0 + 0.025 * smoothstep(0.0,1.0,progress)
	camera_stage.scale = Vector2.ONE * zoom
	camera_stage.position = Vector2(320,180) * (1.0-zoom)
	effects.elapsed = elapsed
	effects.queue_redraw()
	root.modulate.a = transition_start_alpha*(1.0-smoothstep(0.0,FADE_OUT,transition_elapsed)) if transitioning else smoothstep(0.0,0.35,elapsed)

func _process(delta: float) -> void:
	if not started or ended:
		return
	if transitioning:
		elapsed = minf(DURATION,elapsed+delta)
		transition_elapsed = minf(FADE_OUT,transition_elapsed+delta)
		update_stage()
		if transition_elapsed >= FADE_OUT:
			ended = true
			root.hide()
			restore_resolution()
			completed.emit()
		return
	elapsed = minf(DURATION-FADE_OUT,elapsed+delta)
	update_stage()
	if elapsed >= DURATION-FADE_OUT:
		start_handoff()

func start_handoff() -> void:
	if transitioning or ended:
		return
	transitioning = true
	transition_start_alpha = root.modulate.a
	skip_button.disabled = true
	skip_button.hide()
	# The existing VN is prepared beneath this layer, then revealed by fading.
	handoff_requested.emit()

func skip() -> void:
	if not started or get_tree().paused:
		return
	start_handoff()

func _input(event: InputEvent) -> void:
	if not started or ended:
		return
	if event is InputEventKey and event.pressed and not event.echo and event.keycode in [KEY_SPACE,KEY_ENTER,KEY_E]:
		get_viewport().set_input_as_handled()
		skip()

func restore_resolution() -> void:
	if owns_scale_mode:
		get_window().content_scale_mode = original_scale_mode
		owns_scale_mode = false

func _exit_tree() -> void:
	restore_resolution()
