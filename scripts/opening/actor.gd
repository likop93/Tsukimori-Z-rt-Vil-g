extends CharacterBody2D
const ATLAS := preload("res://assets/opening/staging_v3/akira_atlas.png")
const STRIDE := 30.0
var controlled := false
var input_enabled := false
var facing := 2
var visual: Sprite2D
var travel := 0.0
var moving := false
var visited_frames: Dictionary = {}

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
	var desired := axis * 70.0
	velocity = velocity.move_toward(desired,(260.0 if axis != Vector2.ZERO else 350.0)*delta)
	if absf(axis.x) > 0.1:
		facing = 1 if axis.x < 0 else 3
	elif absf(axis.y) > 0.1:
		facing = 2 if axis.y < 0 else 0
	var before := position
	move_and_slide()
	position.y = clampf(position.y,95,339)
	var edges: Vector2 = get_parent().get_parent().lane_limits(position.y)
	position.x = clampf(position.x,edges.x,edges.y)
	var distance := before.distance_to(position)
	moving = distance > 0.01
	visual.flip_h = false
	if moving:
		travel += distance
		var phase := int(travel / STRIDE * 4.0) % 4
		var start := 4 if facing == 1 or facing == 3 else (12 if facing == 2 else 8)
		visual.frame = start + phase
		visual.flip_h = facing == 1
	else:
		travel = 0.0
		# Sheet row 0 is front, right, back, left.
		visual.frame = 3 if facing == 1 else (1 if facing == 3 else facing)
	visited_frames[visual.frame] = true
	queue_redraw()

func _draw() -> void:
	draw_set_transform(Vector2(0,-1),0,Vector2(1,0.28))
	draw_circle(Vector2.ZERO,11,Color(0.015,0.02,0.04,0.55))
