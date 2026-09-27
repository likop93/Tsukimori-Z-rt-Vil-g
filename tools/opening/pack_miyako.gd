extends SceneTree
func _initialize() -> void:
	var source := Image.load_from_file("res://assets/opening/miyako_review/source_REVIEW.png")
	var atlas := Image.create(384,128,false,Image.FORMAT_RGBA8)
	atlas.fill(Color.TRANSPARENT)
	for i in 4:
		var cell := source.get_region(Rect2i(i*source.get_width()/4,0,source.get_width()/4,source.get_height()))
		var body := cell.get_region(cell.get_used_rect())
		body.resize(roundi(body.get_width()*112.0/body.get_height()),112,Image.INTERPOLATE_NEAREST)
		atlas.blit_rect(body,Rect2i(Vector2i.ZERO,body.get_size()),Vector2i(i*96+(96-body.get_width())/2,14))
	atlas.save_png("res://assets/opening/miyako_review/atlas_REVIEW.png")
	quit()
