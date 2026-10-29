extends Control
## Separate vector atmosphere; the source CG and characters remain untouched.
var elapsed := 0.0
var lamp_positions: Array = []

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func _draw() -> void:
	for lamp in lamp_positions:
		var center := Vector2(float(lamp[0])*640.0,float(lamp[1])*360.0)
		var strength := 0.93 + 0.04*sin(elapsed*0.61) + 0.02*sin(elapsed*1.17)
		for ring in range(24,0,-1):
			draw_circle(center,float(ring)*1.6,Color(1.0,0.64,0.29,0.003*strength),true,-1.0,true)
	for i in 18:
		var depth := 0.55 + float(i%4)*0.15
		var x := fposmod(float(i*113)+elapsed*9.0*depth,704.0)-32.0
		var y := fposmod(float(i*71)+elapsed*5.0*depth,408.0)-24.0
		x += sin(elapsed*0.7+float(i))*5.0
		var angle := float(i)*0.7+elapsed*0.25
		var center := Vector2(x,y)
		var axis := Vector2.from_angle(angle)*2.4*depth
		var across := axis.orthogonal()*0.45
		draw_colored_polygon(PackedVector2Array([center-axis,center+across,center+axis,center-across]),Color(0.95,0.75,0.81,0.35+depth*0.12))
