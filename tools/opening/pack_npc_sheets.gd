extends SceneTree
# Engine-side packing of the owner-approved individual sheets. No generative edits.
const SRC := "res://assets/opening/npc_review_v2/"
const OUT := "res://assets/opening/generated/npc_v2/"
const CELL := Vector2i(384,512)
const FRAME := Vector2i(64,96)
func _initialize() -> void:
	DirAccess.make_dir_recursive_absolute(OUT)
	var records: Array = []
	for actor in range(1,5):
		var name := "resident_%02d" % actor
		var source_path := SRC+name+"_REVIEW.png"
		var source := Image.load_from_file(source_path)
		if source == null or source.get_size() != Vector2i(1536,1024):
			push_error("Unexpected source sheet: "+source_path)
			quit(1)
			return
		# The generated alpha has faint exterior residue and 253/255 interiors.
		# Quantize alpha only for nearest-neighbor sprites; never color-key dark clothes.
		source.convert(Image.FORMAT_RGBA8)
		for y in source.get_height():
			for x in source.get_width():
				var color := source.get_pixel(x,y)
				color.a = 1.0 if color.a >= 0.5 else 0.0
				if color.a == 0:
					color = Color.TRANSPARENT
				source.set_pixel(x,y,color)
		var poses: Array[Image] = []
		var boxes: Array[Rect2i] = []
		var tallest := 0
		for frame in range(8):
			var cell := source.get_region(Rect2i(Vector2i(frame%4,frame/4)*CELL,CELL))
			var bounds := cell.get_used_rect()
			if bounds.size.x == 0 or bounds.size.y == 0:
				push_error("Empty pose: "+name+" / "+str(frame))
				quit(1)
				return
			boxes.append(bounds)
			poses.append(cell.get_region(bounds))
			tallest = maxi(tallest,bounds.size.y)
		var height: int = [66,68,61,65][actor-1]
		var scale_factor := float(height)/tallest
		var atlas := Image.create(FRAME.x*4,FRAME.y*2,false,Image.FORMAT_RGBA8)
		atlas.fill(Color.TRANSPARENT)
		var frames: Array = []
		for frame in range(8):
			var pose := poses[frame]
			var size := Vector2i(roundi(pose.get_width()*scale_factor),roundi(pose.get_height()*scale_factor))
			if size.x >= FRAME.x-4 or size.y >= FRAME.y-4:
				push_error("Pose would clip: "+name)
				quit(1)
				return
			pose.resize(size.x,size.y,Image.INTERPOLATE_NEAREST)
			pose = pose.get_region(pose.get_used_rect())
			size = pose.get_size()
			var offset := Vector2i((FRAME.x-size.x)/2,FRAME.y-2-size.y)
			atlas.blit_rect(pose,Rect2i(Vector2i.ZERO,size),Vector2i(frame%4,frame/4)*FRAME+offset)
			frames.append({"index":frame,"source_cell":[frame%4,frame/4],"alpha_bounds":[boxes[frame].position.x,boxes[frame].position.y,boxes[frame].size.x,boxes[frame].size.y],"destination_offset":[offset.x,offset.y],"size":[size.x,size.y],"foot_y":94})
		var target := OUT+name+"_atlas.png"
		atlas.save_png(target)
		records.append({"id":name,"source":source_path,"source_sha256":FileAccess.get_sha256(source_path),"output":target,"output_sha256":FileAccess.get_sha256(target),"frame_size":[64,96],"feet_pivot":[32,94],"scale_factor":scale_factor,"frames":frames,"status":"APPROVED VISUAL SOURCE / ENGINE REVIEW","normalization":"alpha threshold 0.5 to remove faint residue; alpha bounds, one shared scale per actor, nearest sampling, bottom alignment; no recolor, pose synthesis or redesign"})
	var report := {"date":"2026-09-27","source_approval":"Owner: tökéletes, folytassuk","records":records,"limitations":["Left walk uses mirrored right frames","Some source walk phases are similar; production foot-lock review remains","No new character proportions authored"]}
	FileAccess.open(OUT+"atlas_manifest.json",FileAccess.WRITE).store_string(JSON.stringify(report,"  "))
	print("NPC_ATLASES_BUILT: 4 actors, 32 registered RGBA frames")
	quit()
