extends Node
var runner: Node
var done := false
var vn: CanvasLayer
var backdrop: CanvasLayer

func begin() -> void:
	runner.street.player.input_enabled = false
	runner.street.player.velocity = Vector2.ZERO
	runner.street.player.scripted_axis = Vector2.ZERO
	runner.hint.hide()
	runner.heading.hide()
	# Deliberate chapter ellipsis: no invented bedroom or daytime scene.
	backdrop = CanvasLayer.new()
	backdrop.layer = 25
	add_child(backdrop)
	var shade := ColorRect.new()
	shade.size = Vector2(640,360)
	shade.color = Color(0.015,0.02,0.04,0)
	backdrop.add_child(shade)
	var tween := create_tween()
	tween.tween_property(shade,"color:a",1.0,0.7)
	await tween.finished
	var title := Label.new()
	title.text = "Az első éjszaka"
	title.position = Vector2(0,100)
	title.size = Vector2(640,40)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size",24)
	backdrop.add_child(title)
	vn = preload("res://scripts/ui/vn_dialogue.gd").new()
	add_child(vn)
	vn.finished.connect(finish)
	vn.begin(JSON.parse_string(FileAccess.get_file_as_string("res://data/opening/first_night.json")))

func advance(_delta: float) -> void:
	pass

func finish() -> void:
	if done:
		return
	done = true
	GameState.set_flag("first_night_seen")
	var end := Label.new()
	end.text = "Az első fejezet vége"
	end.position = Vector2(0,165)
	end.size = Vector2(640,30)
	end.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	backdrop.add_child(end)
	var menu := Button.new()
	menu.text = "Vissza a főmenübe"
	menu.position = Vector2(220,230)
	menu.size = Vector2(200,36)
	menu.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn"))
	backdrop.add_child(menu)
	menu.grab_focus()
