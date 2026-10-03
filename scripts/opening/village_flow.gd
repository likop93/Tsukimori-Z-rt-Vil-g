extends Node
var runner: Node
var bridge_hold := 0.0
var bridge_noticed := false
var observe_down := false
func advance(delta: float) -> void:
	var down := Input.is_action_pressed("observe")
	var interact := down and not observe_down
	observe_down = down
	var street: Node = runner.street
	var actor: Node = street.player
	if bridge_hold > 0:
		bridge_hold = maxf(0,bridge_hold-delta)
		if bridge_hold == 0:
			runner.dialogue.hide()
			actor.input_enabled = true
		return
	var near_exit := false
	match street.location:
		"street":
			near_exit = actor.position.y < 166
			runner.hint.text = "E · tovább a hídhoz" if near_exit else runner.words.controls
			if near_exit and interact:
				street.show_location("bridge")
				runner.heading.text = "A patakhíd"
		"bridge":
			if actor.position.x > 290 and not bridge_noticed:
				bridge_noticed = true
				bridge_hold = 2.5
				actor.input_enabled = false
				actor.velocity = Vector2.ZERO
				runner.dialogue.show()
				runner.narration.text = "…csak a fény."
				runner.narration.visible_characters = -1
			near_exit = actor.position.x > 535
			runner.hint.text = "E · a túlparti házhoz" if near_exit else runner.words.controls
			if near_exit and interact:
				GameState.set_flag("crossed_bridge")
				street.show_location("house")
				runner.heading.text = "A túlparti ház"
				runner.arrival = preload("res://scripts/opening/arrival_director.gd").new()
				runner.add_child(runner.arrival)
				runner.arrival.runner = runner
				runner.arrival.done = true
				runner.arrival.show_miyako()
		"house":
			if GameState.has_flag("met_miyako"):
				runner.hint.text = "E · belépés a házba" if actor.position.x >= 255 and actor.position.x < 320 else runner.words.controls
				if interact and actor.position.x >= 255 and actor.position.x < 320 and not GameState.has_flag("entered_shared_home"):
					var previous: Node = runner.arrival
					runner.arrival = preload("res://scripts/opening/interior_director.gd").new()
					runner.add_child(runner.arrival)
					runner.arrival.runner = runner
					runner.arrival.begin()
					previous.queue_free()
				return
			near_exit = actor.position.x >= 255 and actor.position.x < 310 and not GameState.has_flag("met_miyako")
			runner.hint.text = "E · Miyako" if near_exit else runner.words.controls
			if near_exit and interact:
				actor.input_enabled = false
				actor.velocity = Vector2.ZERO
				actor.facing = 3
				runner.arrival.phase = "greeting"
				runner.arrival.elapsed = 0
				runner.arrival.done = false
		"interior":
			if GameState.has_flag("first_night_seen"):
				return
			near_exit = actor.position.x > 435
			runner.hint.text = "E · az este folytatása" if near_exit else "A folytatáshoz sétálj jobbra.    WASD / nyilak · séta"
			if near_exit and interact and GameState.has_flag("miyako_interior_dialogue_seen"):
				var previous: Node = runner.arrival
				runner.arrival = preload("res://scripts/opening/first_night_director.gd").new()
				runner.add_child(runner.arrival)
				runner.arrival.runner = runner
				runner.arrival.begin()
				previous.queue_free()
