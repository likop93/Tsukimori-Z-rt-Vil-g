extends SceneTree
# REVIEW technical crops of owner-approved visual sources, never new visual authority.
const SRC := "res://assets/opening/reference/"
const OUT := "res://assets/opening/shot_review_v2/"
const TARGET := Vector2i(640,360)

func _initialize() -> void:
	DirAccess.make_dir_recursive_absolute(OUT)
	var board := Image.load_from_file(SRC+"OPENING_SEQUENCE_STORYBOARD_V1.png")
	var street := Image.load_from_file(SRC+"VILLAGE_STREET_PIXEL_V1.png")
	var plans := [
		["bus_cabin",board,Rect2i(280,47,402,226),"bus interior / Akira"],
		["bus_akira",board,Rect2i(315,80,320,180),"held close-up / Akira"],
		["bus_glass",board,Rect2i(452,60,230,129),"rain and window detail"],
		["bus_road",board,Rect2i(720,52,432,243),"bus nearing village"],
		["arrival_skyline",street,Rect2i(390,35,1120,630),"distant roofs, mist and mountains"],
		["arrival_street",street,Rect2i(0,0,1672,941),"approved wet street approach"],
		["watch_left",street,Rect2i(45,135,760,428),"anonymous left shoji and lamplight"],
		["watch_right",street,Rect2i(890,125,760,428),"anonymous right shoji and lamplight"],
		["gate_wide",board,Rect2i(1246,48,420,236),"village entrance torii"],
		["gate_close",board,Rect2i(1284,80,360,203),"controlled approach to gate"]
	]
	var manifest: Array = []
	for plan in plans:
		var key: String = plan[0]
		var source: Image = plan[1]
		var rect: Rect2i = plan[2]
		if not Rect2i(Vector2i.ZERO,source.get_size()).encloses(rect):
			push_error("Invalid shot rectangle: "+key)
			quit(1)
			return
		var frame := source.get_region(rect)
		frame.resize(TARGET.x,TARGET.y,Image.INTERPOLATE_NEAREST)
		var target := OUT+key+"_REVIEW.png"
		frame.save_png(target)
		manifest.append({"id":key,"status":"REVIEW / TECHNICAL PLACEHOLDER","source":SRC+("VILLAGE_STREET_PIXEL_V1.png" if source == street else "OPENING_SEQUENCE_STORYBOARD_V1.png"),"source_rect":[rect.position.x,rect.position.y,rect.size.x,rect.size.y],"output":target,"output_sha256":FileAccess.get_sha256(target),"size":[TARGET.x,TARGET.y],"method":"source-only crop, nearest resize; no synthetic scene or character","intent":plan[3]})
	FileAccess.open(OUT+"provenance.json",FileAccess.WRITE).store_string(JSON.stringify({"date":"2026-09-27","shots":manifest,"limitations":["These are editorial shots from approved boards, not ten separately painted production CGs.","No named-character reveal or storyboard timing captions are intended in playable crops.","Production-clean bus, rain-glass, anonymous-window and gate animation/CG remain missing."]},"  "))
	print("OPENING_SHOTS_V2_BUILT: "+str(manifest.size()))
	quit()
