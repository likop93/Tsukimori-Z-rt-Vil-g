extends Node2D
# Technical full-body staging from approved references; no invented gait.
var spec: Dictionary
var player: Node2D
var visual: Sprite2D

func _ready() -> void:
	var source: Texture2D = load(str(spec.path))
	var cropped := AtlasTexture.new()
	cropped.atlas = source
	if spec.has("region"):
		var r: Array = spec.region
		cropped.region = Rect2(r[0],r[1],r[2],r[3])
	else:
		cropped.region = source.get_image().get_used_rect()
	visual = Sprite2D.new()
	visual.texture = cropped
	visual.centered = false
	visual.position = Vector2(-cropped.get_width()*0.5,-cropped.get_height())
	visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	add_child(visual)
	scale = Vector2.ONE * float(spec.height)/cropped.get_height()
	queue_redraw()

func _physics_process(_delta: float) -> void:
	if visual == null or player == null or not is_visible_in_tree() or not player.input_enabled:
		return
	if absf(player.position.x-position.x) > 8:
		var source_left := str(spec.get("facing","right")) == "left"
		visual.flip_h = (player.position.x > position.x) if source_left else (player.position.x < position.x)

func _draw() -> void:
	if not bool(spec.get("shadow",true)) or visual == null:
		return
	draw_set_transform(Vector2(0,-2),0,Vector2(1,0.22))
	draw_circle(Vector2.ZERO,visual.texture.get_width()*0.21,Color(0.025,0.02,0.04,0.38))
