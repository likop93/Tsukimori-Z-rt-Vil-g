extends Node
# Only the player-triggered Miyako greeting; traversal is owned by village_flow.
var runner: Node
var phase := "greeting"
var elapsed := 0.0
var done := false
var miyako: Node2D
var vn: CanvasLayer
var living_cg: CanvasLayer
var presentation_started := false

func advance(delta: float) -> void:
	if done or phase != "greeting":
		return
	elapsed += delta
	runner.street.player.scripted_axis = Vector2.ZERO
	miyako.frame = 2 if elapsed > 1.2 and elapsed < 2.4 else 3
	if elapsed >= 1.6 and not presentation_started:
		presentation_started = true
		runner.dialogue.hide()
		runner.hint.hide()
		runner.bubble.hide()
		runner.heading.hide()
		if not try_living_cg():
			begin_dialogue()

func try_living_cg() -> bool:
	var spec: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/opening/miyako_living_cg_REVIEW.json"))
	var path := str(spec.get("texture",""))
	if not bool(spec.get("enabled",false)) or path.is_empty() or not ResourceLoader.exists(path):
		return false
	return start_living_cg(load(path) as Texture2D,spec.get("lamp_positions",[]))

func start_living_cg(texture: Texture2D, lamps: Array = []) -> bool:
	if is_instance_valid(living_cg) or is_instance_valid(vn):
		return false
	living_cg = preload("res://scripts/opening/living_cg.gd").new()
	add_child(living_cg)
	living_cg.handoff_requested.connect(func():
		begin_dialogue()
		vn.active = false
		vn.next_button.disabled = true
	)
	living_cg.completed.connect(func():
		vn.active = true
		vn.next_button.disabled = false
		living_cg.queue_free()
	)
	if not living_cg.begin(texture,lamps):
		living_cg.queue_free()
		living_cg = null
		return false
	return true

func begin_dialogue() -> void:
	if is_instance_valid(vn):
		return
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
