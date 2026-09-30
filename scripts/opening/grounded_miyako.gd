extends Node2D
# The node is the ground contact, never the centre of a portrait cell.
const ATLAS := preload("res://assets/opening/miyako_review/atlas_REVIEW.png")
var visual: Sprite2D
var pivots: Array[Vector2] = []
var body: StaticBody2D
var frame := 0:
	set(value):
		frame = value
		if visual != null:
			visual.frame = frame
			visual.offset = -pivots[frame]
func _ready() -> void:
	var image := ATLAS.get_image()
	for i in 4:
		var bottom := 0
		for y in 128:
			for x in 96:
				if image.get_pixel(i*96+x,y).a > 0.5:
					bottom = maxi(bottom,y)
		var sum_x := 0.0
		var count := 0
		for y in range(bottom-2,bottom+1):
			for x in 96:
				if image.get_pixel(i*96+x,y).a > 0.5:
					sum_x += x
					count += 1
		pivots.append(Vector2(roundf(sum_x/maxi(count,1)),bottom+1))
	visual = Sprite2D.new()
	visual.texture = ATLAS
	visual.hframes = 4
	visual.centered = false
	visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	add_child(visual)
	frame = 0
	body = StaticBody2D.new()
	body.collision_layer = 2
	body.collision_mask = 0
	var shape := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = 17
	shape.shape = circle
	body.add_child(shape)
	add_child(body)
	queue_redraw()
func set_active(active: bool) -> void:
	visible = active
	body.collision_layer = 2 if active else 0
func _draw() -> void:
	draw_set_transform(Vector2(0,-1),0,Vector2(1,0.25))
	draw_circle(Vector2.ZERO,14,Color(0.015,0.02,0.04,0.6))

