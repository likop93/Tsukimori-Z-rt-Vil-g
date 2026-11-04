extends Control
## Alternate day-zero entry, launched only from the chapter selector.
const MENU := "res://scenes/ui/main_menu.tscn"
const CUTS := [0.0, 11.2, 17.6, 24.4, 30.4, 36.6]
const END := 41.6
const MEMORY_START := 6.55
const HAND_RETURN := 9.2
const WARM := preload("res://assets/opening/cinematic_v2/memory_warm_REVIEW.png")
const COLD := preload("res://assets/opening/cinematic_v2/memory_cold_REVIEW.png")
var memory_material := ShaderMaterial.new()
@export var road_cg: Texture2D
@export var parking_cg: Texture2D
@export var walk_cg: Texture2D
var time := 0.0
var shot := -1
var paused_here := false
var finished := false
var meeting_started := false
const BRIDGE_FOOT := preload("res://assets/opening/car_arrival/bridge_cgs/bridge_threshold_REVIEW.png")
const SHION_BANK := preload("res://assets/opening/car_arrival/bridge_cgs/shion_village_bank_REVIEW.png")
const HOUSE_WIDE := preload("res://assets/opening/car_arrival/bridge_cgs/home_clinic_far_bank_REVIEW.png")
var greeting: Node
var brook := AudioStreamPlayer.new()
var controls_layer := CanvasLayer.new()
var pause_button: Button
var skip_button: Button
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
	skip_button = $Skip
	back_button = $Back
	controls_layer.layer = 45
	add_child(controls_layer)
	for button in [pause_button,skip_button,back_button]:
		button.reparent(controls_layer,false)
	brook.stream = preload("res://assets/opening/car_arrival/audio/river_field_loop.wav")
	brook.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(brook)
	brook.finished.connect(brook.play)
	var rain: AudioStreamOggVorbis = preload("res://assets/opening/car_arrival/audio/rain_window.ogg")
	rain.loop = true
	ambience.rain.stream = rain
	ambience.rain.play()
	ambience.configure({})
	ambience.effects.merge({
		"stone1":preload("res://assets/opening/car_arrival/audio/default_hard_footstep.1.ogg"),
		"stone2":preload("res://assets/opening/car_arrival/audio/default_hard_footstep.2.ogg"),
		"board1":preload("res://assets/opening/car_arrival/audio/default_wood_footstep.1.ogg"),
		"board2":preload("res://assets/opening/car_arrival/audio/default_wood_footstep.2.ogg")
	})
	pause_button.pressed.connect(toggle_pause)
	back_button.pressed.connect(back)
	skip_button.pressed.connect(skip_journey)
	memory_material.shader = preload("res://scripts/opening/memory_fragment.gdshader")
	update_frame()

func _process(delta: float) -> void:
	if finished or meeting_started or get_tree().paused:
		return
	time = minf(time+delta, END)
	update_frame()
	if time >= END:
		begin_meeting()

func skip_journey() -> void:
	if not get_tree().paused and not meeting_started:
		begin_meeting(true)

func begin_meeting(skip_film := false) -> void:
	if meeting_started:
		return
	meeting_started = true
	skip_button.hide()
	GameState.set_flag("opening_intro_seen")
	GameState.set_flag("entered_tsukimori")
	GameState.set_flag("crossed_bridge")
	still.texture = HOUSE_WIDE
	still.material = null
	still.scale = Vector2.ONE
	$Subtitle.hide()
	$Dissolve.color.a = 0
	ambience.vehicle.stop()
	greeting = preload("res://scripts/opening/arrival_director.gd").new()
	greeting.process_mode = Node.PROCESS_MODE_PAUSABLE
	greeting.preview_mode = true
	add_child(greeting)
	greeting.preview_finished.connect(enter_home)
	brook.stop()
	ambience.end_cinematic()
	ambience.rain.volume_db = -24
	pause_button.position.y = 4
	back_button.hide()
	get_window().content_scale_mode = original_scale_mode
	if skip_film or not greeting.try_living_cg():
		greeting.begin_dialogue()

func enter_home() -> void:
	if finished:
		return
	finished = true
	ambience.rain.stop()
	GameState.set_flag("met_miyako")
	GameState.set_flag("miyako_first_dialogue_seen")
	GameState.chapter_start = "car_story_interior"
	get_tree().change_scene_to_file.call_deferred("res://scenes/opening/opening.tscn")

func update_memory() -> void:
	if time < MEMORY_START:
		return
	still.material = memory_material
	var memory := time < HAND_RETURN
	var crop := Vector4(0.0,0.49,0.52,0.52)
	var fracture := 0.0
	if time < 7.22:
		still.texture = WARM
		crop = Vector4(0.17,0.34,0.39,0.39)
	elif time < 8.04:
		still.texture = COLD
		crop = Vector4(0.23,0.50,0.45,0.45)
		fracture = 0.55
	elif time < 8.42:
		still.texture = WARM
		crop = Vector4(0.27,0.44,0.28,0.28)
		fracture = 0.85
	elif memory:
		still.texture = COLD
		crop = Vector4(0.28,0.57,0.32,0.32)
		fracture = 0.95
	else:
		still.texture = road_cg
	memory_material.set_shader_parameter("crop",crop)
	memory_material.set_shader_parameter("memory_amount",1.0 if memory else 0.0)
	memory_material.set_shader_parameter("fracture",fracture)
	ambience.vehicle.volume_db = -75
	ambience.rain.volume_db = -48 if memory else lerpf(-75,-29,smoothstep(HAND_RETURN+0.85,CUTS[1],time))

func update_frame() -> void:
	var next := CUTS.bsearch(time,false)-1
	var local_time := time - float(CUTS[next])
	if next != shot:
		shot = next
		still.material = null
		still.texture = [road_cg,parking_cg,walk_cg,BRIDGE_FOOT,SHION_BANK,HOUSE_WIDE][shot]
		still.show()
		var cues := []
		if shot == 0:
			cues = [{"at":MEMORY_START,"sound":"dread"},{"at":7.22,"sound":"pulse"},{"at":HAND_RETURN,"sound":"silence"}]
		elif shot == 1:
			ambience.vehicle.stop()
			cues = [{"at":0.1,"sound":"door"},{"at":0.9,"sound":"step"},{"at":5.65,"sound":"door"}]
		elif shot == 2:
			cues = [{"at":0.3,"sound":"step"},{"at":1.2,"sound":"step"},{"at":2.1,"sound":"step"}]
		elif shot == 3:
			brook.volume_db = -22
			brook.play()
			for i in 10:
				var surface := "stone" if i < 3 else "board"
				cues.append({"at":0.16+i*0.58,"sound":surface+str(1+i%2)})
		elif shot == 4:
			for i in 9:
				cues.append({"at":0.25+i*0.62,"sound":"board"+str(1+i%2)})
		elif shot == 5:
			for i in 4:
				cues.append({"at":0.2+i*0.63,"sound":"stone"+str(1+i%2)})
		ambience.configure({"cues":cues})
	ambience.update_cinematic("car_review", local_time)
	if shot == 0:
		update_memory()
	elif shot == 3:
		brook.volume_db = lerpf(-22,-5,smoothstep(0.0,2.5,local_time))
	elif shot == 5:
		brook.volume_db = lerpf(-5,-34,smoothstep(0,4.8,local_time))
	still.scale = Vector2.ONE * (1.0+0.014*smoothstep(0,7,local_time))
	$Dissolve.color.a = 0.72 * (1.0-smoothstep(0,0.32,local_time))
	var line := ""
	if time < 3.5:
		line = lines.bus[0]
	elif time < MEMORY_START:
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
		if meeting_started:
			toggle_pause()
		else:
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
