extends SceneTree
const OUT := "res://assets/opening/staging_v3/"
func _initialize() -> void:
	var background := Image.load_from_file(OUT+"street_REVIEW.png")
	background.resize(800,450,Image.INTERPOLATE_NEAREST)
	background.get_region(Rect2i(0,0,800,383)).save_png(OUT+"street_stage.png")
	background.get_region(Rect2i(0,383,800,67)).save_png(OUT+"foreground.png")
	# A small, exact source-aligned lane-edge cutout remains visible in the closer camera.
	background.get_region(Rect2i(0,335,800,48)).save_png(OUT+"foreground_close_REVIEW.png")
	var source := Image.load_from_file(OUT+"akira_walk_REVIEW.png")
	source.convert(Image.FORMAT_RGBA8)
	for y in source.get_height():
		for x in source.get_width():
			var c := source.get_pixel(x,y)
			c.a = 1.0 if c.a >= 0.5 else 0.0
			source.set_pixel(x,y,c if c.a > 0 else Color.TRANSPARENT)
	var atlas := Image.create(256,384,false,Image.FORMAT_RGBA8)
	atlas.fill(Color.TRANSPARENT)
	var bands: Array[int] = [0,399,765,1136,1536]
	var frames: Array = []
	# The generated rows have unequal gutters; explicit bands avoid cutting shoes.
	for index in range(16):
		var row: int = index/4
		var cell := source.get_region(Rect2i((index%4)*256,bands[row],256,bands[row+1]-bands[row]))
		var bounds := cell.get_used_rect()
		var pose := cell.get_region(bounds)
		# Shared scale preserves anatomy and the naturally lower passing poses.
		pose.resize(roundi(pose.get_width()*0.19),roundi(pose.get_height()*0.19),Image.INTERPOLATE_NEAREST)
		pose = pose.get_region(pose.get_used_rect())
		var offset := Vector2i((64-pose.get_width())/2,94-pose.get_height())
		atlas.blit_rect(pose,Rect2i(Vector2i.ZERO,pose.get_size()),Vector2i(index%4,row)*Vector2i(64,96)+offset)
		frames.append({"index":index,"height":pose.get_height(),"width":pose.get_width(),"foot_y":94})
	atlas.save_png(OUT+"akira_atlas.png")
	FileAccess.open(OUT+"packing.json",FileAccess.WRITE).store_string(JSON.stringify({"status":"REVIEW","frames":frames,"source_sha256":FileAccess.get_sha256(OUT+"akira_walk_REVIEW.png"),"normalization":"alpha threshold 0.5, shared 0.19 scale, nearest, registered feet; no body stretching"},"  "))
	quit()
