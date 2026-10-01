extends Node
# Only the player-triggered Miyako greeting; traversal is owned by village_flow.
var runner: Node
var phase := "greeting"
var elapsed := 0.0
var done := false
var miyako: Node2D

func advance(delta: float) -> void:
	if done or phase != "greeting":
		return
	elapsed += delta
	runner.street.player.scripted_axis = Vector2.ZERO
	miyako.frame = 2 if elapsed > 1.2 and elapsed < 2.4 else 3
	if elapsed >= 3:
		runner.dialogue.show()
		runner.narration.text = "Miyako: Dr. Akira. Már vártam."
		runner.narration.visible_characters = -1
	if elapsed >= 10:
		finish()

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
	done = true
	runner.finish_arrival()
