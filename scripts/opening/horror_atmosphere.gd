extends CanvasLayer
## Owner-requested gradual horror strand; all assets/cues remain REVIEW.
var ambience: Node
var veil: ColorRect
var sound: AudioStreamPlayer
var elapsed := 0.0
var cooldown := 12.0
var intensity := 0.0
var target := 0.0

func _ready() -> void:
	layer = 28 # Below dialogue, choices and menus, above the scene/photo layer.
	veil = ColorRect.new()
	veil.size = Vector2(640,360)
	veil.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var shader := Shader.new()
	shader.code = """shader_type canvas_item;
uniform float strength = 0.0;
uniform float breath = 0.0;
void fragment() {
    vec2 p = abs(UV - vec2(0.5)) * 2.0;
    float edge = smoothstep(0.25, 1.0, max(p.x, p.y));
    COLOR = vec4(0.015, 0.035, 0.075, strength * (0.025 + edge * (0.065 + breath * 0.006)));
}"""
	var material := ShaderMaterial.new()
	material.shader = shader
	veil.material = material
	add_child(veil)
	sound = AudioStreamPlayer.new()
	add_child(sound)
	GameState.horror_changed.connect(on_pressure)
	on_pressure(GameState.horror_level())

func on_pressure(level: int) -> void:
	target = float(level)
	cooldown = 5.0
	if level == 0:
		intensity = 0.0
		elapsed = 0.0
		if is_instance_valid(sound):
			sound.stop()

func _process(delta: float) -> void:
	intensity = move_toward(intensity,target,delta*0.35)
	elapsed += delta
	veil.material.set_shader_parameter("strength",intensity)
	veil.material.set_shader_parameter("breath",sin(elapsed*0.65))
	veil.visible = intensity > 0.001
	if target < 1.0:
		return
	cooldown -= delta
	if cooldown <= 0.0 and is_instance_valid(ambience):
		var kind := "wind" if target < 2.0 else ("wood" if target < 3.0 else "murmur")
		sound.stream = ambience.make_effect(kind)
		sound.volume_db = -35.0 + target*2.0
		sound.play()
		cooldown = 42.0-target*6.0
