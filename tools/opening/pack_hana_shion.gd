extends SceneTree

func _initialize() -> void:
	for actor in ["hana", "shion"]:
		var source := Image.load_from_file("res://assets/opening/hana_shion_cameos/"+actor+"_source_REVIEW.png")
		var atlas := Image.create(192,128,false,Image.FORMAT_RGBA8)
		atlas.fill(Color.TRANSPARENT)
		for col in 2:
			var cell := source.get_region(Rect2i(col*source.get_width()/2,0,source.get_width()/2,source.get_height()))
			for y in cell.get_height():
				for x in cell.get_width():
					if cell.get_pixel(x,y).a < 0.5:
						cell.set_pixel(x,y,Color.TRANSPARENT)
			var frame := cell.get_region(cell.get_used_rect())
			frame.resize(roundi(frame.get_width()*90.0/frame.get_height()),90,Image.INTERPOLATE_NEAREST)
			# Keep the head still between gestures and shoes on baseline 124.
			var sum_x := 0.0
			var count := 0
			for y in range(4,18):
				for x in frame.get_width():
					if frame.get_pixel(x,y).a > 0.5:
						sum_x += x
						count += 1
			atlas.blit_rect(frame,Rect2i(Vector2i.ZERO,frame.get_size()),Vector2i(col*96+48-roundi(sum_x/maxi(count,1)),34))
		atlas.save_png("res://assets/opening/hana_shion_cameos/"+actor+"_atlas_REVIEW.png")
	quit()
