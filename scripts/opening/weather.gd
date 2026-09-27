extends Node2D
var elapsed := 0.0
var drops: Array[Vector3] = []
var active := true
func _ready() -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = 260927
	for i in 105:
		drops.append(Vector3(rng.randf_range(0,660),rng.randf_range(0,380),rng.randf_range(80,150)))
func _process(delta: float) -> void:
	elapsed += delta
	if active:
		queue_redraw()
func _draw() -> void:
	if not active:
		return
	for d in drops:
		var p := Vector2(fposmod(d.x-elapsed*15,660)-10,fposmod(d.y+elapsed*d.z,380)-10).round()
		draw_line(p,p+Vector2(-2,7),Color(0.61,0.72,0.87,0.16),1)
	for i in 12:
		var x := fposmod(float(i*61)+elapsed*2,660)-10
		var y := 277+sin(elapsed*0.2+i)*12
		draw_rect(Rect2(x,y,100,2),Color(0.55,0.65,0.76,0.018))
