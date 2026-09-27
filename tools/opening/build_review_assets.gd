extends SceneTree
# Reproducible technical extraction only. Never a FINAL pixel-art conversion.
const SRC := "res://assets/opening/reference/"
const OUT := "res://assets/opening/generated/"
var manifest: Array = []

func _initialize() -> void:
	DirAccess.make_dir_recursive_absolute(OUT)
	var akira := Image.load_from_file(SRC + "AKIRA_FINAL_CHARACTER_DESIGN_V1.png")
	var atlas := Image.create(48 * 4, 80 * 5, false, Image.FORMAT_RGBA8)
	atlas.fill(Color.TRANSPARENT)
	var front := cut_polygon(akira, [[339,20],[371,28],[384,70],[380,98],[413,116],[435,168],[431,235],[414,276],[425,384],[423,494],[438,551],[435,564],[398,562],[385,520],[360,394],[344,503],[343,550],[264,557],[261,545],[298,521],[306,430],[297,334],[284,275],[268,239],[273,167],[286,121],[311,104],[309,65],[311,34]])
	var side := cut_polygon(akira, [[480,23],[512,31],[527,70],[520,101],[538,126],[546,217],[527,308],[531,411],[527,505],[543,546],[533,557],[462,556],[447,546],[449,535],[479,511],[479,427],[464,347],[462,277],[448,248],[451,166],[464,119],[458,99],[452,66]])
	var back := cut_polygon(akira, [[620,24],[650,27],[673,61],[664,94],[692,124],[704,211],[689,270],[684,343],[688,443],[693,517],[700,550],[688,559],[659,558],[648,524],[639,408],[612,517],[608,552],[560,555],[553,546],[566,521],[580,391],[568,287],[559,241],[550,194],[563,130],[597,102],[590,68],[603,37]])
	put_frame(atlas, front, 0, 0, 70)
	put_frame(atlas, side, 1, 0, 70)
	var right := side.duplicate()
	right.flip_x()
	put_frame(atlas, right, 2, 0, 70)
	put_frame(atlas, back, 3, 0, 70)
	var npc := Image.load_from_file(SRC + "VILLAGE_NPC_ATTRACTIVE_VARIANTS_V2.png")
	var population := Image.load_from_file(SRC + "VILLAGE_NPC_PACK_V1_WOMEN_ONLY.png")
	# Adult residents only; never named/special characters from the board.
	var crops := [Rect2i(1244,132,34,66), Rect2i(991,266,37,67), Rect2i(1290,266,36,67), Rect2i(275,566,36,64)]
	for row in range(1, 5):
		var source := npc if row == 1 else population
		var pose := silhouette(source.get_region(crops[row - 1]))
		for col in range(4):
			var frame := pose.duplicate()
			if col == 1:
				frame.flip_x()
			put_frame(atlas, frame, col, row, 59 if row != 3 else 55)
	# The same anonymous woman has actual example walk/turn poses.
	put_frame(atlas, silhouette(npc.get_region(Rect2i(1244,204,34,65))), 3, 1, 59)
	put_frame(atlas, silhouette(npc.get_region(Rect2i(1277,275,34,64))), 1, 1, 59)
	put_frame(atlas, silhouette(npc.get_region(Rect2i(1310,275,34,64))), 2, 1, 59)
	atlas.save_png(OUT + "actors_REVIEW.png")
	manifest.append({"asset":"actors_REVIEW.png","status":"PLACEHOLDER / REVIEW","frame":[48,80],"pivot":[24,80],"rows":["Akira primary","anonymous adult animation example","middle-aged resident","elderly resident","shop worker"],"sources":["AKIRA_FINAL_CHARACTER_DESIGN_V1.png","VILLAGE_NPC_ATTRACTIVE_VARIANTS_V2.png","VILLAGE_NPC_PACK_V1_WOMEN_ONLY.png"],"npc_crop_rects":[[1244,132,34,66],[991,266,37,67],[1290,266,36,67],[275,566,36,64]],"limitations":"Akira: source silhouette extraction, no production walk cycle. Other residents: held poses except row 1 example walk. No redesign, no FINAL claim."})
	var street := Image.load_from_file(SRC + "VILLAGE_STREET_PIXEL_V1.png")
	street.resize(800,450,Image.INTERPOLATE_NEAREST)
	street.save_png(OUT + "street_REVIEW.png")
	var fg := cut_polygon_full(street, [[0,298],[43,300],[70,318],[147,319],[215,338],[280,350],[357,358],[414,347],[444,350],[455,411],[514,409],[555,431],[607,429],[632,450],[0,450]])
	fg.save_png(OUT + "foreground_REVIEW.png")
	manifest.append({"asset":"street_REVIEW.png / foreground_REVIEW.png","source":"VILLAGE_STREET_PIXEL_V1.png","status":"APPROVED PLAYABLE BASE / REVIEW technical layers","operation":"nearest 800x450 and source-only polygon foreground extraction","limitations":"Missing clean painted depth layers and hidden surface reconstruction. Flattened source remains under cutout."})
	var board := Image.load_from_file(SRC + "OPENING_SEQUENCE_STORYBOARD_V1.png")
	var shots := {"bus":Rect2i(280,46,402,230),"arrival":Rect2i(704,37,526,270),"watch":Rect2i(13,431,491,166),"gate":Rect2i(960,412,330,168)}
	for key in shots:
		var shot := board.get_region(shots[key])
		shot.save_png(OUT + key + "_REVIEW.png")
		manifest.append({"asset":key + "_REVIEW.png","source":"OPENING_SEQUENCE_STORYBOARD_V1.png","rect":[shots[key].position.x,shots[key].position.y,shots[key].size.x,shots[key].size.y],"status":"PLACEHOLDER","limitations":"Storyboard panel, original staging retained; dedicated production CG missing."})
	var f := FileAccess.open(OUT + "provenance.json",FileAccess.WRITE)
	f.store_string(JSON.stringify(manifest,"  "))
	print("REVIEW_ASSETS_BUILT: atlas, street, foreground, four storyboard panels.")
	quit()

func put_frame(atlas: Image, source: Image, col: int, row: int, height: int) -> void:
	var frame := source.duplicate()
	var width := mini(46, roundi(float(frame.get_width()) / frame.get_height() * height))
	frame.resize(width,height,Image.INTERPOLATE_NEAREST)
	atlas.blit_rect(frame,Rect2i(Vector2i.ZERO,frame.get_size()),Vector2i(col*48+(48-width)/2,row*80+80-height))

func cut_polygon(source: Image, points: Array) -> Image:
	var full := cut_polygon_full(source,points)
	return full.get_region(full.get_used_rect())

func cut_polygon_full(source: Image, points: Array) -> Image:
	var poly := PackedVector2Array()
	for p in points:
		poly.append(Vector2(p[0],p[1]))
	var result := Image.create(source.get_width(),source.get_height(),false,Image.FORMAT_RGBA8)
	result.fill(Color.TRANSPARENT)
	for y in source.get_height():
		for x in source.get_width():
			if Geometry2D.is_point_in_polygon(Vector2(x,y),poly):
				result.set_pixel(x,y,source.get_pixel(x,y))
	return result

func silhouette(source: Image) -> Image:
	var points: Array = []
	# Conservative silhouette masks, retaining dark interior clothing pixels.
	for p in [[0.40,0.02],[0.70,0.02],[0.88,0.15],[0.86,0.30],[0.75,0.39],[0.93,0.53],[0.90,0.73],[0.81,0.83],[0.89,0.98],[0.15,0.98],[0.17,0.84],[0.08,0.69],[0.09,0.51],[0.26,0.37],[0.21,0.20]]:
		points.append([p[0]*source.get_width(),p[1]*source.get_height()])
	return cut_polygon(source,points)
