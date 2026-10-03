extends SceneTree
func _initialize() -> void:
	var atlas := Image.create(384,256,false,Image.FORMAT_RGBA8)
	atlas.fill(Color.TRANSPARENT)
	for row in 2:
		var source := Image.load_from_file("res://assets/opening/kuroe_cameo/"+("walk" if row == 0 else "glance")+"_source_REVIEW.png")
		for col in 4:
			var cell := source.get_region(Rect2i(col*source.get_width()/4,0,source.get_width()/4,source.get_height()))
			# Remove near-transparent generation fringe before measuring the baseline.
			for y in cell.get_height():
				for x in cell.get_width():
					var pixel := cell.get_pixel(x,y)
					if pixel.a < 0.5:
						cell.set_pixel(x,y,Color.TRANSPARENT)
			var bounds := cell.get_used_rect()
			var frame := cell.get_region(bounds)
			frame.resize(roundi(frame.get_width()*90.0/frame.get_height()),90,Image.INTERPOLATE_NEAREST)
			var foot_x := 0.0
			var count := 0
			for y in range(87,90):
				for x in frame.get_width():
					if frame.get_pixel(x,y).a > 0.5:
						foot_x += x
						count += 1
			var at := Vector2i(col*96+48-roundi(foot_x/maxi(count,1)),row*128+34)
			atlas.blit_rect(frame,Rect2i(Vector2i.ZERO,frame.get_size()),at)
	atlas.save_png("res://assets/opening/kuroe_cameo/atlas_REVIEW.png")
	quit()
