extends "res://tests/ui/vn_dialogue_regression.gd"
## Default: synthetic mechanics. --approved-cg: real configured source and captures.
var approved_source := false

func capture_cg(label: String) -> void:
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png("res://review/living_cg_"+label+"_REVIEW.png")

func fixture() -> Texture2D:
	var texture := GradientTexture2D.new()
	texture.width = 1920
	texture.height = 1080
	texture.gradient = Gradient.new()
	texture.gradient.colors = PackedColorArray([Color("#15334d"),Color("#c58a56")])
	return texture

func _ready() -> void:
	get_window().unfocusable = true # Automated input must not capture desktop typing.
	approved_source = "--approved-cg" in OS.get_cmdline_user_args()
	var original_mode := get_window().content_scale_mode
	for skip_early in [false,true]:
		preload("res://scripts/ui/chapter_catalog.gd").prepare("miyako")
		var runner: Node = load("res://scenes/opening/opening.tscn").instantiate()
		add_child(runner)
		var arrival: Node = runner.arrival
		if approved_source:
			arrival.advance(0.0)
			check(is_instance_valid(arrival.living_cg),"Approved config starts through real greeting trigger")
		else:
			arrival.presentation_started = true
			check(arrival.start_living_cg(fixture(),[[0.75,0.3]]),"Synthetic fixture starts through real arrival controller")
		var cg: CanvasLayer = arrival.living_cg
		if not is_instance_valid(cg):
			get_tree().quit(1)
			return
		if not approved_source:
			var marker := Label.new()
			marker.text = "TECHNICAL FIXTURE / NO APPROVED CG"
			marker.position = Vector2(25,290)
			marker.add_theme_font_size_override("font_size",14)
			cg.root.add_child(marker)
		else:
			check(cg.picture.texture.get_size() == Vector2(1672,941),"Original approved resolution retained")
			check(cg.picture.texture.resource_path.ends_with("01_USER_PREFERRED_REVIEW.png"),"Preferred source used, not alternative")
		await get_tree().process_frame
		check(get_window().content_scale_mode == Window.CONTENT_SCALE_MODE_CANVAS_ITEMS,"CG uses window-resolution canvas instead of 640px raster upscaling")
		check(cg.picture.texture_filter == CanvasItem.TEXTURE_FILTER_LINEAR,"CG uses linear filtering")
		check(not GameState.has_flag("met_miyako") and GameState.aff_miyako == 0,"Cinematic grants no completion or affinity")
		var before_position: Vector2 = runner.street.player.position
		Input.action_press("walk_right")
		await get_tree().create_timer(0.2).timeout
		Input.action_release("walk_right")
		check(runner.street.player.position == before_position,"No walking during cinematic")
		var start_zoom: Vector2 = cg.camera_stage.scale
		runner.pause_menu.open_menu()
		var paused_at: float = cg.elapsed
		await press(KEY_SPACE)
		cg.skip()
		await get_tree().create_timer(0.2).timeout
		check(cg.elapsed == paused_at and not cg.transitioning,"Pause freezes animation and blocks skip")
		runner.pause_menu.resume()
		if skip_early:
			# Test the actual on-screen Skip control as well as repeated requests.
			cg.skip_button.pressed.emit()
			cg.skip() # Repeated skip cannot duplicate the VN.
		else:
			if approved_source:
				for at_time in [1.0,4.0,7.8,8.6]:
					while is_instance_valid(cg) and cg.elapsed < at_time:
						await get_tree().process_frame
					if not is_instance_valid(cg):
						check(false,"Cinematic ended before requested capture")
						get_tree().quit(1)
						return
					print("LIVING_CG_FRAME: ",cg.elapsed)
					await capture_cg(str(at_time).replace(".","_"))
			else:
				await get_tree().create_timer(4.0).timeout
			check(cg.camera_stage.scale.x > start_zoom.x and cg.camera_stage.scale.x < 1.026,"Slow bounded camera zoom")
			if not approved_source:
				await RenderingServer.frame_post_draw
				get_viewport().get_texture().get_image().save_png("res://review/living_cg_TECHNICAL_FIXTURE.png")
		var timeout := 0.0
		while is_instance_valid(arrival.living_cg) and timeout < 11.0:
			await get_tree().process_frame
			timeout += get_process_delta_time()
		check(timeout < 11.0,"Cinematic terminates")
		check(get_window().content_scale_mode == original_mode,"VN restores original pixel viewport rendering")
		var vn: CanvasLayer = arrival.vn
		check(is_instance_valid(vn) and vn.active and vn.index == 0,"Natural/skip handoff preserves the first greeting")
		check(vn.dialogue_panel.size.y == 78 and vn.portrait.position.x > 320,"Approved October 22 layout retained")
		check(not GameState.has_flag("met_miyako"),"Watching or skipping does not acknowledge dialogue")
		if approved_source and not skip_early:
			await capture_cg("09_dialogue")
		for step in 12:
			if not vn.active:
				break
			await press(KEY_SPACE)
		check(GameState.has_flag("miyako_first_dialogue_seen") and GameState.has_flag("met_miyako"),"Final VN acknowledgement completes encounter")
		check(GameState.aff_miyako == 0 and not GameState.has_flag("miyako_transformation_revealed"),"No relationship or transformation side effects")
		runner.queue_free()
		await get_tree().process_frame
		await get_tree().process_frame
	# Aborting via the menu must also restore resolution, even before handoff.
	var cancelled := preload("res://scripts/opening/living_cg.gd").new()
	add_child(cancelled)
	check(not cancelled.begin(null),"Missing source is rejected without changing display mode")
	check(get_window().content_scale_mode == original_mode,"Missing source preserves display")
	check(cancelled.begin(fixture()),"Cancellation fixture begins")
	cancelled.queue_free()
	await get_tree().process_frame
	await get_tree().process_frame
	check(get_window().content_scale_mode == original_mode,"Scene destruction restores display mode")
	print("LIVING_CG_MECHANICS: "+JSON.stringify({"passed":failures.is_empty(),"failures":failures,"approved_source":approved_source,"visual_review":"manual screenshots required"}))
	get_tree().quit(0 if failures.is_empty() else 1)
