extends Node
# Live actors and scene plates; no video and no player movement until the greeting ends.
var runner: Node
var phase := "street"
var elapsed := 0.0
var done := false
var miyako: Sprite2D
var phrase_index := -1

func start(owner_runner: Node) -> void:
	runner = owner_runner
	runner.street.player.scripted_speed = 17
	for resident in runner.street.residents:
		resident.watch_arrival = true
	runner.hint.text = "Érkezés Tsukimoriba · Esc: átvezető kihagyása"
	runner.heading.hide()

func advance(delta: float) -> void:
	if done:
		return
	elapsed += delta
	var actor: Node = runner.street.player
	match phase:
		"street":
			actor.scripted_axis = Vector2.UP if elapsed < 10 else Vector2.ZERO
			var index := mini(2,int(elapsed/4))
			if index != phrase_index:
				phrase_index = index
				runner.show_bubble(runner.street.residents[index].phrase,runner.street.residents[index].position)
			runner.bubble_time = maxf(0,runner.bubble_time-delta)
			runner.position_bubble()
			if elapsed >= 13:
				enter_phase("bridge")
		"bridge":
			actor.scripted_axis = Vector2.RIGHT if elapsed < 8 or elapsed > 11 else Vector2.ZERO
			actor.scripted_speed = 25
			# Street owns the surveyed deck path and foreground rail occlusion.
			if elapsed >= 8 and elapsed < 11:
				runner.dialogue.show()
				runner.narration.text = "…csak a fény."
				runner.narration.visible_characters = -1
			else:
				runner.dialogue.hide()
			if elapsed >= 21:
				GameState.set_flag("crossed_bridge")
				enter_phase("house")
		"house":
			actor.scripted_axis = Vector2.RIGHT if actor.position.x < 270 else Vector2.ZERO
			actor.scripted_speed = 22
			if elapsed >= 7:
				enter_phase("greeting")
		"greeting":
			actor.scripted_axis = Vector2.ZERO
			miyako.frame = 2 if elapsed > 1.2 and elapsed < 2.4 else 3
			if elapsed >= 3:
				runner.dialogue.show()
				runner.narration.text = "Miyako: Dr. Akira. Már vártam."
				runner.narration.visible_characters = -1
			if elapsed >= 10:
				finish()

func enter_phase(next: String) -> void:
	phase = next
	elapsed = 0
	runner.bubble.hide()
	runner.dialogue.hide()
	runner.street.player.scripted_axis = Vector2.ZERO
	if next in ["bridge","house"]:
		runner.street.show_location(next)
		# A short fade conceals the camera/position reset between continuous scenes.
		runner.street.modulate.a = 0
		create_tween().tween_property(runner.street,"modulate:a",1.0,0.65)
	if next == "house":
		show_miyako()

func show_miyako() -> void:
	if is_instance_valid(miyako):
		return
	miyako = Sprite2D.new()
	miyako.texture = load("res://assets/opening/miyako_review/atlas_REVIEW.png")
	miyako.hframes = 4
	miyako.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	miyako.position = Vector2(352,193)
	runner.street.add_child(miyako)

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
