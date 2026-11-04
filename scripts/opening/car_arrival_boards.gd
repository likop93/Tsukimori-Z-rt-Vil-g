extends Control
## Moving layout boards for the three unavailable original CGs.
const AKIRA := preload("res://assets/opening/staging_v3/akira_atlas.png")
var shot := 0
var seconds := 0.0

func shape(points: PackedVector2Array, color: String) -> void:
	draw_colored_polygon(points, Color(color))

func _draw() -> void:
	# Dusk and distant ridgelines are shared geography across all three cuts.
	for band in 90:
		var sky := Color("#243044").lerp(Color("#e1aa88"), float(band) / 89.0)
		draw_rect(Rect2(0, band * 2, 640, 2), sky)
	var drift := seconds * 3.5 if shot == 0 else 0.0
	for ridge in 3:
		var peaks := PackedVector2Array([Vector2(-4, 240)])
		for i in range(-1, 43):
			var x := i * 16.0
			var phase := x + drift * (ridge + 1)
			var y := 83 + ridge * 32 + sin(phase * 0.018 + ridge) * 18 + sin(phase * 0.038) * 6
			peaks.append(Vector2(x, y))
		peaks.append(Vector2(674, 240))
		shape(peaks, ["#8e7e86", "#605e70", "#414b5a"][ridge])
	draw_rect(Rect2(0, 170, 640, 190), Color("#32464c"))
	for i in (17 if shot != 0 else 0):
		var x := fposmod(i * 43.0 - drift * 0.7, 690.0) - 24.0
		var y := 158 + sin(i * 1.1) * 8.0
		draw_rect(Rect2(x, y, 18, 12), Color("#30343b"))
		shape([Vector2(x-4,y), Vector2(x+7,y-6), Vector2(x+22,y)], "#232a32")
		draw_rect(Rect2(x+4,y+4,3,4),Color("#e5b078"))
		draw_rect(Rect2(x+11,y+4,2,4),Color("#c49a72"))
	# Winding approach with the village beyond the pull-off.
	shape([Vector2(-140,360),Vector2(115,254),Vector2(410,198),Vector2(495,173),Vector2(453,160),Vector2(473,160),Vector2(525,173),Vector2(450,207),Vector2(255,268),Vector2(165,360)], "#64626b")
	draw_rect(Rect2(0, 256, 640, 104), Color("#4d515a"))
	draw_line(Vector2(0,266), Vector2(640,266), Color("#85838a"), 2)
	for i in 12:
		var x := fposmod(i * 65.0 - drift * 6.0, 740.0) - 60.0
		draw_line(Vector2(x,288), Vector2(x+35,288), Color("#9f968b"), 2)
	if shot == 0:
		# The road is wooded; the settlement first comes into view at the cut.
		for i in 28:
			var x := fposmod(i*31.0-drift*2.8,760)-64
			var y := 206.0 + 20.0*sin(i*1.6)
			var height := 40.0 + 18.0*cos(i*2.2)
			draw_rect(Rect2(x-1,y-height,3,height),Color("#313f47"))
			for tier in 3:
				var width := 6.0 + tier*3.0
				var tip := y-height+tier*9.0
				shape([Vector2(x,tip),Vector2(x+width,tip+height*0.5),Vector2(x-width,tip+height*0.5)],"#35434c")
	if shot < 2:
		var x := lerpf(111,351,seconds/7.6) if shot == 0 else lerpf(282,350,smoothstep(0,3.0,seconds))
		car(Vector2(x,258), 0.64 if shot == 0 else 1.28, shot == 1 and seconds < 3.1)
	else:
		car(Vector2(270,277), 2.55, false)
		var door := smoothstep(0.15,1.25,seconds) * (1.0-smoothstep(4.2,5.2,seconds))
		if seconds > 0.8:
			# Existing side idle. Crop the emerging figure at the sill; the final foot is y=285.
			var lift := smoothstep(0.8,2.65,seconds)
			var x := lerpf(244,299,lift)
			var body_top := lerpf(196,141,lift)
			var body_height := minf(144,285-body_top)
			draw_texture_rect_region(AKIRA,Rect2(x-24,body_top,48,body_height),Rect2(212,22,24,body_height/2))
		if door > 0.02:
			var edge := Vector2(255-door*90,206+door*20)
			shape([Vector2(255,206),edge,edge+Vector2(0,62),Vector2(255,262)], "#303c49")
			shape([Vector2(255,206),edge,edge+Vector2(8*door,-28),Vector2(255,170)], "#767982")
			draw_line(edge,Vector2(255,206),Color("#b1a099"),2)
	for i in 48:
		var x := fposmod(i*113.0 - seconds*26,654)-7
		var y := fposmod(i*79.0 + seconds*105,374)-12
		draw_line(Vector2(x,y),Vector2(x-2,y+7),Color(0.84,0.88,0.94,0.17),1,true)

func car(center: Vector2, scale_factor: float, brakes: bool) -> void:
	draw_set_transform(center,0,Vector2.ONE*scale_factor)
	draw_set_transform(center+Vector2(0,3)*scale_factor,0,Vector2(1,0.1)*scale_factor)
	draw_circle(Vector2.ZERO,69,Color("#343a40"))
	draw_set_transform(center,0,Vector2.ONE*scale_factor)
	shape([Vector2(-65,-7),Vector2(-64,-23),Vector2(-49,-28),Vector2(-31,-47),Vector2(9,-48),Vector2(33,-29),Vector2(58,-23),Vector2(66,-14),Vector2(65,-6)], "#26303a")
	shape([Vector2(-45,-29),Vector2(-29,-43),Vector2(-11,-43),Vector2(-11,-29)], "#68737b")
	shape([Vector2(-8,-29),Vector2(-8,-43),Vector2(8,-43),Vector2(28,-29)], "#88878a")
	draw_line(Vector2(-58,-23),Vector2(56,-20),Color("#817b7f"),1.5,true)
	draw_line(Vector2(-10,-27),Vector2(-10,-9),Color("#19232d"),1)
	for wheel in [-42,42]:
		draw_circle(Vector2(wheel,-7),10,Color("#19202a"),true,-1,true)
		draw_circle(Vector2(wheel,-7),5,Color("#57606a"),true,-1,true)
	draw_rect(Rect2(-65,-21,5,4),Color("#ff6952") if brakes else Color("#984e50"))
	draw_rect(Rect2(57,-21,7,4),Color("#f6deb0"))
	draw_set_transform(Vector2.ZERO,0,Vector2.ONE)
