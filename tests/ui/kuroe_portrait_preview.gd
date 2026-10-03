extends Node
func _ready() -> void:
	var art := TextureRect.new()
	art.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	art.texture = preload("res://assets/opening/reference/SHARED_HOME_CLINIC_INTERIOR_PIXEL_V1.png")
	art.size = Vector2(640,360)
	art.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	add_child(art)
	var vn := preload("res://scripts/ui/vn_dialogue.gd").new()
	add_child(vn)
	vn.begin({"portrait_speaker":"Kuroe","portrait_path":"res://assets/opening/vn_portraits/kuroe_neutral_v1_REVIEW.png","lines":[{"speaker":"Kuroe","text":"Karakterelőnézet · REVIEW"}]})
	vn.advance()
	await RenderingServer.frame_post_draw
	assert(vn.portrait.texture.get_image().get_pixel(0,0).a < 0.01,"Transparent background required")
	assert(vn.portrait.modulate == Color.WHITE,"Active Kuroe portrait must be lit")
	get_viewport().get_texture().get_image().save_png("res://review/kuroe_vn_preview.png")
	print("KUROE_PREVIEW: passed")
	get_tree().quit()
