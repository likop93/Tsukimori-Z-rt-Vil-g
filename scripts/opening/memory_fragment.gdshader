shader_type canvas_item;

uniform vec4 crop = vec4(0.0, 0.0, 1.0, 1.0);
uniform float memory_amount = 1.0;
uniform float fracture = 0.0;

void fragment() {
	vec2 uv = UV;
	float seam = uv.x + uv.y * 0.34 - 0.62;
	uv.x += step(0.0, seam) * fracture * 0.026;
	vec3 source = texture(TEXTURE, crop.xy + clamp(uv, vec2(0.0), vec2(1.0)) * crop.zw).rgb;
	float grey = dot(source, vec3(0.299, 0.587, 0.114));
	vec3 red = vec3(grey * 1.25 + 0.09, grey * 0.27, grey * 0.28);
	float crack = (1.0 - smoothstep(0.001, 0.004, abs(seam))) * fracture;
	COLOR = vec4(mix(source, red * (1.0 - crack * 0.88), memory_amount), 1.0);
}
