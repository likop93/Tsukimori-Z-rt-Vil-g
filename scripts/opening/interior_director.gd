extends Node
var runner: Node
var done := false
var vn: CanvasLayer

func begin() -> void:
	runner.street.player.input_enabled = false
	runner.street.player.velocity = Vector2.ZERO
	runner.street.player.scripted_axis = Vector2.ZERO
	runner.hint.hide()
	runner.heading.hide()
	runner.bubble.hide()
	var transition := CanvasLayer.new()
	transition.layer = 40
	add_child(transition)
	var veil := ColorRect.new()
	veil.size = Vector2(640,360)
	veil.color = Color(0,0,0,0)
	transition.add_child(veil)
	var tween := create_tween()
	tween.tween_property(veil,"color:a",1.0,0.4)
	await tween.finished
	runner.street.show_location("interior")
	runner.weather.active = false
	runner.weather.hide()
	runner.ambience.rain.volume_db = -29
	GameState.set_flag("entered_shared_home")
	tween = create_tween()
	tween.tween_property(veil,"color:a",0.0,0.5)
	await tween.finished
	transition.queue_free()
	vn = preload("res://scripts/ui/vn_dialogue.gd").new()
	add_child(vn)
	vn.choice_selected.connect(on_choice)
	vn.finished.connect(finish)
	vn.begin(JSON.parse_string(FileAccess.get_file_as_string("res://data/opening/miyako_interior_dialogue.json")))

func advance(_delta: float) -> void:
	pass

func on_choice(id: String) -> void:
	if not GameState.miyako_first_choice.is_empty():
		return
	GameState.miyako_first_choice = id
	if id == "listen":
		GameState.aff_miyako += 1
		GameState.akira_gyogyulas += 1

func finish() -> void:
	if done:
		return
	done = true
	GameState.set_flag("miyako_interior_dialogue_seen")
	runner.village_flow.observe_down = Input.is_action_pressed("observe")
	runner.heading.text = "Közös otthon"
	runner.heading.show()
	runner.hint.visible = runner.help_visible
	runner.street.enable_control()
