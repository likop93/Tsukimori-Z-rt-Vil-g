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
					# The generated strip spills a few pixels of the previous boot
					# into the next cell's otherwise empty bottom-left margin.
					if pixel.a < 0.5 or (x < 24 and y > cell.get_height()*0.8):
						cell.set_pixel(x,y,Color.TRANSPARENT)
			var bounds := cell.get_used_rect()
			var frame := cell.get_region(bounds)
			frame.resize(roundi(frame.get_width()*90.0/frame.get_height()),90,Image.INTERPOLATE_NEAREST)
			# Stabilize the upper body instead of centering whichever foot is
			# currently planted. Foot centering made the head jerk at passing poses.
			var head_x := 0.0
			var count := 0
			for y in range(4,18):
				for x in frame.get_width():
					if frame.get_pixel(x,y).a > 0.5:
						head_x += x
						count += 1
			var at := Vector2i(col*96+48-roundi(head_x/maxi(count,1)),row*128+34)
			atlas.blit_rect(frame,Rect2i(Vector2i.ZERO,frame.get_size()),at)
	atlas.save_png("res://assets/opening/kuroe_cameo/atlas_REVIEW.png")
	quit()
