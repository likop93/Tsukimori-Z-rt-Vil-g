extends Node2D
var street: Node2D
var visual: Sprite2D
var elapsed := 0.0
var started := false
var done := false
var visited: Dictionary = {}
const SPEED := 45.0
const START := Vector2(380,177)
const END_X := 685.0

func _ready() -> void:
	visual = Sprite2D.new()
	visual.texture = preload("res://assets/opening/kuroe_cameo/atlas_REVIEW.png")
	visual.hframes = 4
	visual.vframes = 2
	visual.centered = false
	visual.position = Vector2(-48,-124)
	visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	# Clip this actor and its shadow at the painted house edges, in world
	# coordinates. The rest of the cast and camera remain untouched.
	var mask := Shader.new()
	mask.code = "shader_type canvas_item; varying vec2 world; void vertex(){ world=(MODEL_MATRIX*vec4(VERTEX,0.0,1.0)).xy; } void fragment(){ float left_edge=430.0-0.18*(177.0-world.y); float right_edge=615.0+0.08*(177.0-world.y); if(world.x<left_edge || world.x>right_edge) discard; }"
	var occlusion := ShaderMaterial.new()
	occlusion.shader = mask
	material = occlusion
	visual.use_parent_material = true
	add_child(visual)
	position = START
	scale = Vector2.ONE*1.15
	hide()

func _physics_process(delta: float) -> void:
	if done:
		return
	if street.location != "street":
		if started:
			finish()
		return
	if not started:
		if not street.player.input_enabled or street.player.position.y > 245:
			return
		started = true
		show()
	elapsed += delta
	position.x = minf(END_X,START.x+elapsed*SPEED)
	var glance: bool = position.x >= 500 and position.x < 536 and street.player.position.distance_to(position) < 200
	visual.frame = int((position.x-START.x)/28.0*4.0)%4 + (4 if glance else 0)
	visited[visual.frame] = true
	# Keep opaque: appearance/disappearance is caused by architecture.
	modulate.a = 1.0
	queue_redraw()
	if position.x >= END_X:
		finish()

func finish() -> void:
	done = true
	hide()
	GameState.set_flag("kuroe_cameo_passed")

func _draw() -> void:
	draw_set_transform(Vector2(0,-1),0,Vector2(1,0.25))
	draw_circle(Vector2.ZERO,12,Color(0.015,0.02,0.04,0.5))
