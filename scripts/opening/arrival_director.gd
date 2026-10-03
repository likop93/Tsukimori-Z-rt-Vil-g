extends Node
# Only the player-triggered Miyako greeting; traversal is owned by village_flow.
var runner: Node
var phase := "greeting"
var elapsed := 0.0
var done := false
var miyako: Node2D
var vn: CanvasLayer

func advance(delta: float) -> void:
	if done or phase != "greeting":
		return
	elapsed += delta
	runner.street.player.scripted_axis = Vector2.ZERO
	miyako.frame = 2 if elapsed > 1.2 and elapsed < 2.4 else 3
	if elapsed >= 1.6 and not is_instance_valid(vn):
		runner.dialogue.hide()
		runner.hint.hide()
		runner.bubble.hide()
		vn = preload("res://scripts/ui/vn_dialogue.gd").new()
		add_child(vn)
		vn.finished.connect(finish)
		vn.begin(JSON.parse_string(FileAccess.get_file_as_string("res://data/opening/miyako_first_dialogue.json")))

func show_miyako() -> void:
	if is_instance_valid(miyako):
		return
	miyako = preload("res://scripts/opening/grounded_miyako.gd").new()
	miyako.position = Vector2(352,274)
	runner.street.player.get_parent().add_child(miyako)
	runner.street.featured_actor = miyako

func finish() -> void:
	if done:
		return
	if runner.street.location != "house":
		runner.street.show_location("house")
		runner.street.player.position = Vector2(270,274)
	show_miyako()
	runner.street.modulate.a = 1
	runner.street.player.scripted_axis = Vector2.ZERO
	runner.street.player.velocity = Vector2.ZERO
	runner.street.player.facing = 3
	GameState.set_flag("met_miyako")
	GameState.set_flag("miyako_first_dialogue_seen")
	# Consume the closing E press before returning to exploration.
	runner.village_flow.observe_down = Input.is_action_pressed("observe")
	done = true
	runner.finish_arrival()
