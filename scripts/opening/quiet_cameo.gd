extends Node2D
# REVIEW two-pose cameos; no dialogue, collider, or camera takeover.
var street: Node2D
var identity := "hana"
var visual: Sprite2D
var reacted := false
var reaction_time := 0.0

func _ready() -> void:
	visual = Sprite2D.new()
	visual.texture = load("res://assets/opening/hana_shion_cameos/"+identity+"_atlas_REVIEW.png")
	visual.hframes = 2
	visual.centered = false
	visual.position = Vector2(-48,-124)
	visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	add_child(visual)
	position = Vector2(375,231) if identity == "hana" else Vector2(183,165)
	scale = Vector2.ONE*(1.25 if identity == "hana" else 0.80)
	hide()

func refresh_visibility() -> void:
	visible = street.enabled and street.location == ("street" if identity == "hana" else "bridge")

func _physics_process(delta: float) -> void:
	refresh_visibility()
	if not visible or not street.player.input_enabled:
		return
	if not reacted:
		var near: bool = street.player.position.distance_to(position) < (155.0 if identity == "hana" else 75.0)
		# Shion watches first and turns away only after Akira approaches the bank.
		if near and (identity == "hana" or street.player.position.x >= 150):
			reacted = true
			GameState.set_flag(identity+"_cameo_seen")
	if reacted:
		reaction_time += delta
		visual.frame = 1 if identity == "shion" or reaction_time < 2.4 else 0

func _draw() -> void:
	draw_set_transform(Vector2(0,-1),0,Vector2(1,0.25))
	draw_circle(Vector2.ZERO,12,Color(0.015,0.02,0.04,0.5))
