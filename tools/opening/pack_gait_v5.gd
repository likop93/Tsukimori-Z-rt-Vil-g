extends SceneTree
func _initialize() -> void:
	var source := Image.load_from_file("res://assets/opening/gait_v5/side_source_REVIEW.png")
	source.convert(Image.FORMAT_RGBA8)
	for y in source.get_height():
		for x in source.get_width():
			var pixel := source.get_pixel(x,y)
			pixel.a = 1.0 if pixel.a >= 0.5 else 0.0
			source.set_pixel(x,y,pixel if pixel.a > 0 else Color.TRANSPARENT)
	var poses: Array[Image] = []
	var tallest := 1
	for i in 8:
		var cell := source.get_region(Rect2i(i%4*source.get_width()/4,i/4*source.get_height()/2,source.get_width()/4,source.get_height()/2))
		var body := cell.get_region(cell.get_used_rect())
		tallest = maxi(tallest,body.get_height())
		poses.append(body)
	var atlas := Image.create(256,192,false,Image.FORMAT_RGBA8)
	atlas.fill(Color.TRANSPARENT)
	for i in 8:
		var pose := poses[i]
		pose.resize(roundi(pose.get_width()*71.0/tallest),roundi(pose.get_height()*71.0/tallest),Image.INTERPOLATE_NEAREST)
		# Register the torso rather than the moving hands/feet bounding box.
		var sum_x := 0.0
		var count := 0
		for y in range(roundi(pose.get_height()*0.27),roundi(pose.get_height()*0.48)):
			for x in pose.get_width():
				if pose.get_pixel(x,y).a > 0:
					sum_x += x
					count += 1
		var pivot := roundi(sum_x/maxi(1,count))
		atlas.blit_rect(pose,Rect2i(Vector2i.ZERO,pose.get_size()),Vector2i(i%4*64+32-pivot,i/4*96+94-pose.get_height()))
	atlas.save_png("res://assets/opening/gait_v5/side_atlas_REVIEW.png")
	quit()
