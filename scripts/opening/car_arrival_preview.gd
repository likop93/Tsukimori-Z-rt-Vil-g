extends Control
## Standalone pacing review. The menu launches it without preparing a chapter.
const MENU := "res://scenes/ui/main_menu.tscn"
const CUTS := [0.0, 7.6, 14.0, 20.8, 33.0]
const END := 38.0
@export var road_cg: Texture2D
@export var parking_cg: Texture2D
@export var walk_cg: Texture2D
var time := 0.0
var shot := -1
var paused_here := false
var finished := false
var meeting_started := false
var street: Node2D
var greeting: Node
var brook := AudioStreamPlayer.new()
var controls_layer := CanvasLayer.new()
var pause_button: Button
var replay_button: Button
var back_button: Button
var lines := {}
var original_scale_mode: Window.ContentScaleMode
@onready var still: TextureRect = $Still
@onready var ambience := $Ambience
@onready var caption: Label = $Subtitle/Text

func _ready() -> void:
	original_scale_mode = get_window().content_scale_mode
	get_window().content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
	process_mode = Node.PROCESS_MODE_ALWAYS
	ambience.process_mode = Node.PROCESS_MODE_PAUSABLE
	var sequence: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/opening/sequence.json"))
	for beat in sequence.beats:
		lines[beat.id] = beat.get("lines", [])
	pause_button = $Pause
	replay_button = $Replay
	back_button = $Back
	controls_layer.layer = 45
	add_child(controls_layer)
	for button in [pause_button,replay_button,back_button]:
		button.reparent(controls_layer,false)
	brook.stream = preload("res://assets/opening/car_arrival/audio/brook_REVIEW.wav")
	brook.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(brook)
	brook.finished.connect(brook.play)
	pause_button.pressed.connect(toggle_pause)
	back_button.pressed.connect(back)
	replay_button.pressed.connect(func(): get_tree().reload_current_scene())
	update_frame()

func _process(delta: float) -> void:
	if finished or meeting_started or get_tree().paused:
		return
	time = minf(time+delta, END)
	update_frame()
	if time >= END:
		begin_meeting()

func begin_meeting() -> void:
	meeting_started = true
	street.player.scripted_axis = Vector2.ZERO
	street.player.velocity = Vector2.ZERO
	brook.stop()
	ambience.end_cinematic()
	ambience.rain.volume_db = -24
	pause_button.position.y = 4
	back_button.position.y = 4
	get_window().content_scale_mode = original_scale_mode
	if not greeting.try_living_cg():
		greeting.begin_dialogue()

func end_preview() -> void:
	finished = true
	ambience.rain.stop()
	pause_button.hide()
	replay_button.show()
	back_button.position.y = replay_button.position.y
	replay_button.grab_focus()

func enter_street(location: String) -> void:
	if not is_instance_valid(street):
		street = preload("res://scenes/opening/village_street.tscn").instantiate()
		street.process_mode = Node.PROCESS_MODE_PAUSABLE
		street.z_index = -30
		add_child(street)
	street.show_location(location)
	still.hide()
	street.player.controlled = false
	street.player.scripted_axis = Vector2.RIGHT
	if location == "bridge":
		street.player.scale = Vector2.ONE*0.72
		street.player.scripted_speed = 39
		street.residents[0].scale = Vector2.ONE*0.64
		var watcher: Node2D = street.residents[1]
		watcher.scale = Vector2.ONE*0.63
		watcher.set_physics_process(false)
		brook.volume_db = -23
		brook.play()
	else:
		street.player.scale = Vector2.ONE*0.97
		street.player.scripted_speed = 34
		for resident in street.residents:
			resident.scale = Vector2.ONE*0.77
		greeting = preload("res://scripts/opening/arrival_director.gd").new()
		greeting.process_mode = Node.PROCESS_MODE_PAUSABLE
		greeting.preview_mode = true
		greeting.runner = self
		add_child(greeting)
		greeting.show_miyako()
		greeting.miyako.scale = Vector2.ONE*0.66
		greeting.miyako.frame = 3
		greeting.preview_finished.connect(end_preview)

func update_frame() -> void:
	var next := CUTS.bsearch(time,false)-1
	var local_time := time - float(CUTS[next])
	if next != shot:
		shot = next
		if shot < 3:
			still.texture = [road_cg,parking_cg,walk_cg][shot]
			still.show()
		else:
			enter_street("bridge" if shot == 3 else "house")
		var cues := []
		if shot == 0:
			cues = [{"at":5.2,"sound":"depart"}]
		elif shot == 1:
			cues = [{"at":0.1,"sound":"door"},{"at":0.9,"sound":"step"},{"at":5.65,"sound":"door"}]
		elif shot == 2:
			cues = [{"at":0.3,"sound":"step"},{"at":1.2,"sound":"step"},{"at":2.1,"sound":"step"}]
		if shot == 3:
			for i in 22:
				cues.append({"at":0.2+i*0.54,"sound":"step" if i < 5 or i >= 21 else "plank"})
		elif shot == 4:
			for i in 7:
				cues.append({"at":0.2+i*0.52,"sound":"step"})
		ambience.configure({"cues":cues})
		if shot == 3:
			ambience.effects["plank"] = preload("res://assets/opening/car_arrival/audio/plank_step_REVIEW.wav")
	ambience.update_cinematic("car_review", local_time)
	if shot == 3:
		var watcher: Node2D = street.residents[1]
		var approach := clampf((local_time-2.4)/2.0,0,1)
		watcher.position = Vector2(lerpf(537,548,approach),203)
		watcher.state = "look" if approach >= 1 else ("slow_walk" if approach > 0 else "idle")
		watcher.travel_distance = 11*approach
		watcher.update_frame()
		brook.volume_db = lerpf(-19,-6,smoothstep(0.2,3.0,local_time))
	elif shot == 4:
		brook.volume_db = lerpf(-12,-65,smoothstep(0,2,local_time))
		if local_time >= 2.0:
			brook.stop()
		if street.player.position.x >= 270:
			street.player.scripted_axis = Vector2.ZERO
	still.scale = Vector2.ONE * (1.0+0.014*smoothstep(0,7,local_time))
	$Dissolve.color.a = 0.72 * (1.0-smoothstep(0,0.32,local_time))
	var line := ""
	if time < 3.5:
		line = lines.bus[0]
	elif time < CUTS[1]:
		line = lines.bus[3]
	elif local_time < 3.8 and shot == 1:
		line = lines.forest[0]
	elif shot == 2 and local_time >= 2.6 and local_time < 6.4:
		line = lines.recover[0]
	elif shot == 3 and local_time >= 0.7 and local_time < 4.3:
		line = lines.forest[1]
	caption.text = line
	$Subtitle.visible = not line.is_empty()

func toggle_pause() -> void:
	if finished:
		return
	paused_here = not paused_here
	get_tree().paused = paused_here
	pause_button.text = "Folytatás" if paused_here else "Szünet"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		back()
	elif event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_TAB:
		get_viewport().set_input_as_handled()
		toggle_pause()

func back() -> void:
	if paused_here:
		toggle_pause()
	ambience.rain.stop()
	ambience.vehicle.stop()
	brook.stop()
	ambience.end_cinematic()
	get_tree().change_scene_to_file(MENU)

func _exit_tree() -> void:
	get_window().content_scale_mode = original_scale_mode
	if paused_here:
		get_tree().paused = false
