extends CharacterBody2D
const ATLAS := preload("res://assets/opening/staging_v3/akira_atlas.png")
const SIDE_ATLAS := preload("res://assets/opening/gait_v5/side_atlas_REVIEW.png")
const RUN_ATLAS := preload("res://assets/opening/run_v1/side_atlas_REVIEW.png")
const STRIDE := 24.0
const WALK_SPEED := 70.0
const RUN_SPEED := 118.0
var running := false
var street: Node2D
var controlled := false
var input_enabled := false
var facing := 2
var visual: Sprite2D
var travel := 0.0
var moving := false
var visited_frames: Dictionary = {}
var scripted_axis := Vector2.ZERO
var scripted_speed := 28.0
var floor_min := 95.0
var floor_max := 339.0

func _ready() -> void:
	collision_layer = 1
	collision_mask = 2
	var shape := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = 5
	shape.shape = circle
	add_child(shape)
	visual = Sprite2D.new()
	visual.texture = ATLAS
	visual.hframes = 4
	visual.vframes = 4
	visual.position = Vector2(0,-46)
	visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	visual.modulate = Color.WHITE
	add_child(visual)

func _physics_process(delta: float) -> void:
	var axis := Input.get_vector("walk_left","walk_right","walk_up","walk_down") if input_enabled and controlled else Vector2.ZERO
	if not input_enabled:
		axis = scripted_axis
	running = input_enabled and controlled and axis != Vector2.ZERO and Input.is_action_pressed("run")
	var speed := RUN_SPEED if running else WALK_SPEED
	var desired := axis * (speed if input_enabled else scripted_speed)
	velocity = velocity.move_toward(desired,(420.0 if running else 260.0 if axis != Vector2.ZERO else 500.0)*delta)
	if absf(axis.x) > 0.1:
		facing = 1 if axis.x < 0 else 3
	elif absf(axis.y) > 0.1:
		facing = 2 if axis.y < 0 else 0
	var before := position
	move_and_slide()
	position = street.constrain_position(position)
	var distance := before.distance_to(position)
	moving = distance > 0.01
	visual.flip_h = false
	if moving:
		travel += distance / maxf(scale.x,0.1)
		var side := facing == 1 or facing == 3
		visual.texture = RUN_ATLAS if side and running else SIDE_ATLAS if side else ATLAS
		visual.vframes = 1 if side and running else 2 if side else 4
		var frame_count := 4 if running else 8 if side else 4
		var phase := int(travel / (28.0 if running else STRIDE) * frame_count) % frame_count
		visual.frame = phase if side else (12 if facing == 2 else 8) + phase
		visual.flip_h = facing == 1
	else:
		visual.texture = ATLAS
		visual.vframes = 4
		# Verified against the full-resolution source: front, LEFT, back, RIGHT.
		# Direction codes use that same order; do not swap the side idle cells.
		visual.frame = facing
	visited_frames[visual.frame] = true
	queue_redraw()

func _draw() -> void:
	draw_set_transform(Vector2(0,-1),0,Vector2(1,0.28))
	draw_circle(Vector2.ZERO,11,Color(0.015,0.02,0.04,0.55))
