extends Control
# A navigation guide, not a fast-travel menu. Reveals places, never identities.
var tour: Node
const POS := {
	"school":Vector2(100,84),"shop":Vector2(290,84),"inn":Vector2(480,84),
	"market":Vector2(100,177),"square":Vector2(290,177),"craft_lane":Vector2(480,177),
	"shrine":Vector2(100,270),"stream":Vector2(290,270),"bridge":Vector2(480,270)
}
const TITLES := {"school":"Iskola","shop":"Vegyesbolt","inn":"Fogadó","market":"Piactér","square":"Főtér","craft_lane":"Műhely / zenés ház","shrine":"Szentélyút","stream":"Patakpart","bridge":"Híd → otthon"}

func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var shade := ColorRect.new()
	shade.color = Color(0.025,0.03,0.055,0.96)
	shade.size = Vector2(640,360)
	add_child(shade)
	var lines := Node2D.new()
	add_child(lines)
	for id in POS:
		for exit_spec in tour.layout[id].exits:
			var target: String = exit_spec.target
			if not POS.has(target) or id > target:
				continue
			var line := Line2D.new()
			line.points = PackedVector2Array([POS[id]+Vector2(30,0),POS[target]+Vector2(30,0)])
			line.width = 2
			line.default_color = Color("#65536c")
			lines.add_child(line)
	for id in POS:
		var box := Panel.new()
		box.position = POS[id]-Vector2(55,21)
		box.size = Vector2(170,43)
		var style := StyleBoxFlat.new()
		style.bg_color = Color("#403245") if id == tour.area else Color("#181c29")
		style.border_color = Color("#e3bb7d") if id == tour.area else Color("#786174")
		style.set_border_width_all(1)
		style.set_corner_radius_all(5)
		box.add_theme_stylebox_override("panel",style)
		add_child(box)
		var label := Label.new()
		var done := 0
		for stop in tour.layout[id].stops:
			if tour.visited.has(stop):
				done += 1
		label.text = ("● " if id == tour.area else "")+str(TITLES[id])
		if not tour.layout[id].stops.is_empty():
			label.text += "  %d/%d" % [done,tour.layout[id].stops.size()]
		label.size = box.size
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		label.add_theme_font_size_override("font_size",12)
		box.add_child(label)
	var title := Label.new()
	title.text = "TSUKIMORI  ·  ELSŐ SZABAD DÉLUTÁN"
	title.position = Vector2(25,16)
	title.add_theme_font_size_override("font_size",17)
	add_child(title)
	var close := Button.new()
	close.text = "M · Vissza a sétához"
	close.position = Vector2(225,318)
	close.size = Vector2(190,30)
	close.pressed.connect(tour.toggle_map)
	add_child(close)
