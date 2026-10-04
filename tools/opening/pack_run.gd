extends SceneTree
func _initialize() -> void:
	var source := Image.load_from_file("res://assets/opening/run_v1/side_source_REVIEW.png")
	var poses: Array[Image] = []
	var tallest := 1
	for i in 4:
		var cell := source.get_region(Rect2i(i*source.get_width()/4,0,source.get_width()/4,source.get_height()))
		for y in cell.get_height():
			for x in cell.get_width():
				if cell.get_pixel(x,y).a < 0.5:
					cell.set_pixel(x,y,Color.TRANSPARENT)
		var body := cell.get_region(cell.get_used_rect())
		poses.append(body)
		tallest = maxi(tallest,body.get_height())
	var atlas := Image.create(256,96,false,Image.FORMAT_RGBA8)
	atlas.fill(Color.TRANSPARENT)
	for i in 4:
		var pose := poses[i]
		pose.resize(roundi(pose.get_width()*71.0/tallest),roundi(pose.get_height()*71.0/tallest),Image.INTERPOLATE_NEAREST)
		var sum_x := 0.0
		var count := 0
		for y in range(4,16):
			for x in pose.get_width():
				if pose.get_pixel(x,y).a > 0.5:
					sum_x += x
					count += 1
		# Common head height keeps flight shoes above the ground baseline.
		atlas.blit_rect(pose,Rect2i(Vector2i.ZERO,pose.get_size()),Vector2i(i*64+32-roundi(sum_x/maxi(count,1)),23))
	atlas.save_png("res://assets/opening/run_v1/side_atlas_REVIEW.png")
	quit()
