extends Control
# Destination selection. Names identify places, not undiscovered characters.
var tour: Node
const POS := {
	"school":Vector2(24,70),"shop":Vector2(232,70),"inn":Vector2(440,70),
	"market":Vector2(24,142),"square":Vector2(232,142),"craft_lane":Vector2(440,142),
	"shrine":Vector2(24,214),"stream":Vector2(232,214),"bridge":Vector2(440,214)
}
const TITLES := {"school":"Iskola","shop":"Vegyesbolt","inn":"Fogadó","market":"Piactér","square":"Főtér","craft_lane":"Műhelyek utcája","shrine":"Szentélyút","stream":"Patakpart","bridge":"Híd"}

func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var shade := ColorRect.new()
	shade.color = Color(0.025,0.03,0.055,0.97)
	shade.size = Vector2(640,360)
	add_child(shade)
	var title := Label.new()
	title.text = "TSUKIMORI  ·  HOVÁ INDULSZ?"
	title.position = Vector2(24,18)
	title.add_theme_font_size_override("font_size",17)
	add_child(title)
	var subtitle := Label.new()
	subtitle.text = GameState.calendar_label()+" · Otthonról is visszatérhetsz."
	subtitle.position = Vector2(24,43)
	subtitle.add_theme_font_size_override("font_size",12)
	add_child(subtitle)
	# Schematic paths preserve the village topology; destinations are clickable.
	var roads := Node2D.new()
	add_child(roads)
	for id in POS:
		for exit_spec in tour.layout[id].exits:
			var target := str(exit_spec.target)
			if target != "home" and (not POS.has(target) or id > target):
				continue
			var line := Line2D.new()
			var end: Vector2 = Vector2(475,312) if target == "home" else POS[target]+Vector2(88,26)
			line.points = PackedVector2Array([POS[id]+Vector2(88,26),end])
			line.width = 2
			line.default_color = Color("#665341")
			roads.add_child(line)
	for id in POS:
		var done := 0
		var total: int = tour.layout[id].stops.size()
		for stop in tour.layout[id].stops:
			if tour.visited.has(stop):
				done += 1
		var caption: String = ("● " if id == tour.area else "")+str(TITLES[id])
		caption += "\n"+("Itt vagy" if id == tour.area else "Odamegyek")
		if total > 0:
			caption += "  ·  %d/%d" % [done,total]
		var button: Button = tour.make_button(self,"destination_"+id,caption,POS[id],Vector2(176,53),tour.navigate.bind(id))
		button.tooltip_text = "Ma már jártál itt." if GameState.visited_today(id) else "Ma még nem jártál itt."
		if id == tour.area:
			var selected := button.get_theme_stylebox("normal").duplicate() as StyleBoxFlat
			selected.border_color = Color("#efd19a")
			selected.bg_color = Color("#3c303a")
			button.add_theme_stylebox_override("normal",selected)
	tour.make_button(self,"destination_home","Otthon · Miyako háza",Vector2(335,292),Vector2(281,40),tour.navigate.bind("home"))
	tour.make_button(self,"close_map","Vissza a helyszínhez · M",Vector2(24,292),Vector2(281,40),tour.toggle_map)
