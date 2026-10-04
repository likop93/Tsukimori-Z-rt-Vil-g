extends Control
## REVIEW decoration derived from the approved dialogue UI reference.

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	resized.connect(queue_redraw)

func _draw() -> void:
	var rose := Color("a96973")
	var gold := Color("cba47b")
	for origin in [Vector2(3,3),Vector2(size.x-3,3),Vector2(3,size.y-3),size-Vector2(3,3)]:
		var direction := Vector2(1 if origin.x < size.x/2 else -1,1 if origin.y < size.y/2 else -1)
		var points := PackedVector2Array()
		for offset in [Vector2(0,15),Vector2(0,6),Vector2(6,6),Vector2(6,0),Vector2(20,0)]:
			points.append(origin+offset*direction)
		draw_polyline(points,gold,1)
	if size.y > 50:
		draw_line(Vector2(18,size.y-29),Vector2(size.x-18,size.y-29),Color(0.65,0.4,0.43,0.24),1)
	else:
		# A small five-petal blossom sits outside the text's left margin.
		var center := Vector2(12,size.y/2)
		for i in range(5):
			var angle := float(i)*TAU/5-PI/2
			var tip := center+Vector2.from_angle(angle)*7
			var tangent := Vector2.from_angle(angle+PI/2)*2
			draw_colored_polygon(PackedVector2Array([center,tip+tangent,tip+Vector2.from_angle(angle)*2,tip-tangent]),rose)
		draw_rect(Rect2(center-Vector2.ONE,Vector2(3,3)),gold)
