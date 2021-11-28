shader_type canvas_item;

uniform float doodle_size : hint_range(2, 16) = 8;
uniform float doodle_speed : hint_range(1, 16) = 5;
uniform float doodle_intensity: hint_range(1, 100) = 5;
uniform float smooth_value : hint_range(0, 1) = 0.45;
uniform float fade : hint_range(0.0, 1.0) = 1.0;


vec2 doodle_uv(vec2 uv, float size, float speed, float intensity, float time)
{
	speed = (floor(time * 2.5 * speed) / speed) * speed;
	vec2 new_uv = vec2(sin((uv.x * size + speed) * 4.), cos((uv.y * size + speed) * 4.));
	uv = mix(uv, uv + new_uv, intensity * 0.0001 * size);
	return uv;
}


void fragment()
{
	vec2 uv = doodle_uv(UV, doodle_size, doodle_speed, doodle_intensity, TIME);
	uv = mix(UV, uv, smooth_value);
	vec4 output_color = texture(TEXTURE, uv);
	
	output_color.a *= fade;
	COLOR = output_color;
}
