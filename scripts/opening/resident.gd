extends Node2D
# Dedicated animation controller for individually approved female resident sheets.
const WALK_CYCLE_DISTANCE := 12.0
var row := 1 # Source identity retained for the milestone diagnostics.
var atlas: Texture2D
var visual: Sprite2D
var player: Node2D
var behavior := "idle"
var phrase := ""
var roam_range := 0.0
var walk_speed := 8.0
var direction := 1.0
var home_x := 0.0
var look_time := 0.0
var look_cooldown := 0.0
var clock := 0.0
var state := "idle"
var state_elapsed := 0.0
var travel_distance := 0.0
var look_left_frame := 2
var look_right_frame := 3
var mirror_left_look := false
var visited_states: Dictionary = {}
var visited_frames: Dictionary = {}

func _ready() -> void:
	assert(atlas != null, "Each resident requires its own approved atlas")
	home_x = position.x
	clock = row * 1.4
	visual = Sprite2D.new()
	visual.texture = atlas
	visual.hframes = 4
	visual.vframes = 2
	# Every frame's foot pivot is (32,94) in a 64x96 frame.
	visual.position = Vector2(0,-46)
	visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	visual.modulate = Color.WHITE
	add_child(visual)
	update_frame()
	queue_redraw()

func _physics_process(delta: float) -> void:
	clock += delta
	state_elapsed += delta
	look_cooldown = maxf(0,look_cooldown-delta)
	if player != null and player.input_enabled and position.distance_to(player.position) < 68 and look_cooldown <= 0:
		look_time = 2.2
		look_cooldown = 9
	if look_time > 0:
		look_time = maxf(0,look_time-delta)
		set_state("look")
	elif behavior == "slow_walk" and roam_range > 0 and fmod(clock,9.0) > 3:
		set_state("slow_walk")
		var old_x := position.x
		position.x = clampf(position.x+direction*walk_speed*delta,home_x-roam_range,home_x+roam_range)
		travel_distance += absf(position.x-old_x)
		if position.x >= home_x+roam_range:
			direction = -1
		elif position.x <= home_x-roam_range:
			direction = 1
	else:
		set_state("idle")
	update_frame()

func set_state(next_state: String) -> void:
	if state != next_state:
		state = next_state
		state_elapsed = 0
		if next_state == "slow_walk":
			travel_distance = 0
	visited_states[next_state] = true

func update_frame() -> void:
	if visual == null:
		return
	visual.flip_h = false
	match state:
		"look":
			var left := player != null and player.position.x < position.x
			visual.frame = look_left_frame if left else look_right_frame
			visual.flip_h = left and mirror_left_look
		"slow_walk":
			visual.frame = 4 + int(travel_distance / WALK_CYCLE_DISTANCE * 4.0) % 4
			visual.flip_h = direction < 0
		_:
			visual.frame = int(state_elapsed*0.7) % 2
	visited_frames[visual.frame] = true

func _draw() -> void:
	draw_set_transform(Vector2(0,-1),0,Vector2(1,0.28))
	draw_circle(Vector2.ZERO,12,Color(0.015,0.02,0.04,0.55))
