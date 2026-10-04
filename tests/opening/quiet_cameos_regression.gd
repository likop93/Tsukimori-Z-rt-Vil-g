extends Node
var failures: Array[String] = []
func check(ok: bool, message: String) -> void:
	if not ok:
		failures.append(message)
		push_error(message)

func capture(file: String) -> void:
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/"+file+".png")

func _ready() -> void:
	GameState.clear_runtime_state()
	var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
	add_child(runner)
	var hana: Node2D = runner.street.quiet_cameos[0]
	var shion: Node2D = runner.street.quiet_cameos[1]
	await get_tree().create_timer(0.2).timeout
	check(not hana.visible and not shion.visible,"Named cameos stay hidden during intro")
	runner.skip_all()
	await get_tree().create_timer(0.1).timeout
	check(hana.visible and not shion.visible and not hana.reacted,"Street arrival shows Hana before her reaction")
	runner.street.player.position = Vector2(465,235)
	await get_tree().create_timer(0.2).timeout
	check(hana.reacted and hana.visual.frame == 1 and GameState.has_flag("hana_cameo_seen"),"Hana raises her gaze near Akira")
	check(runner.street.player.input_enabled and not runner.dialogue.visible,"Hana leaves exploration control free")
	await capture("hana_cameo")
	var feet: Vector2 = hana.position
	await get_tree().create_timer(2.5).timeout
	check(hana.visual.frame == 0 and hana.position == feet,"Hana resumes sleeve pose without shifting feet")
	runner.street.show_location("bridge")
	await get_tree().create_timer(0.1).timeout
	check(not hana.visible and shion.visible and not shion.reacted,"Shion watches from bridge bank")
	await capture("shion_watching")
	runner.street.player.position = runner.street.constrain_position(Vector2(155,190))
	await get_tree().create_timer(0.2).timeout
	check(shion.reacted and shion.visual.frame == 1 and GameState.has_flag("shion_cameo_seen"),"Shion looks away when Akira approaches")
	check(absf(shion.position.y-runner.street.player.position.y) >= 20,"Shion stands off the walking path")
	check(runner.street.player.input_enabled,"Shion leaves exploration control free")
	await capture("shion_cameo")
	runner.street.show_location("house")
	check(not hana.visible and not shion.visible,"Cameos never leak into house scene")
	for actor in ["hana","shion"]:
		var texture: Texture2D = load("res://assets/opening/hana_shion_cameos/"+actor+"_atlas_REVIEW.png")
		var atlas := texture.get_image()
		check(atlas.get_pixel(0,0).a == 0,"Atlas background is transparent")
		for col in 2:
			var bounds := atlas.get_region(Rect2i(col*96,0,96,128)).get_used_rect()
			check(bounds.end.y == 124 and bounds.size.y == 90,"Both poses keep the same foot baseline and height")
	print("QUIET_CAMEOS: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures}))
	get_tree().quit(0 if failures.is_empty() else 1)
