extends Control
## Standalone pacing review. The menu launches it without preparing a chapter.
const MENU := "res://scenes/ui/main_menu.tscn"
const CUTS := [0.0, 7.6, 14.0]
const END := 20.8
@export var road_cg: Texture2D
@export var parking_cg: Texture2D
@export var walk_cg: Texture2D
var time := 0.0
var shot := -1
var paused_here := false
var finished := false
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
	$Pause.pressed.connect(toggle_pause)
	$Back.pressed.connect(back)
	$Replay.pressed.connect(func(): get_tree().reload_current_scene())
	update_frame()

func _process(delta: float) -> void:
	if finished or get_tree().paused:
		return
	time = minf(time+delta, END)
	update_frame()
	if time >= END:
		finished = true
		ambience.rain.stop()
		ambience.end_cinematic()
		$Pause.hide()
		$Replay.show()
		$Replay.grab_focus()

func update_frame() -> void:
	var next := 2 if time >= CUTS[2] else (1 if time >= CUTS[1] else 0)
	var local_time := time - float(CUTS[next])
	if next != shot:
		shot = next
		still.texture = [road_cg,parking_cg,walk_cg][shot]
		still.show()
		var cues := []
		if shot == 0:
			cues = [{"at":5.2,"sound":"depart"}]
		elif shot == 1:
			cues = [{"at":0.1,"sound":"door"},{"at":0.9,"sound":"step"},{"at":5.65,"sound":"door"}]
		else:
			cues = [{"at":0.3,"sound":"step"},{"at":1.2,"sound":"step"},{"at":2.1,"sound":"step"}]
		ambience.configure({"cues":cues})
	ambience.update_cinematic("car_review", local_time)
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
	caption.text = line
	$Subtitle.visible = not line.is_empty()

func toggle_pause() -> void:
	if finished:
		return
	paused_here = not paused_here
	get_tree().paused = paused_here
	$Pause.text = "Folytatás" if paused_here else "Szünet"

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
	ambience.end_cinematic()
	get_tree().change_scene_to_file(MENU)

func _exit_tree() -> void:
	get_window().content_scale_mode = original_scale_mode
	if paused_here:
		get_tree().paused = false
