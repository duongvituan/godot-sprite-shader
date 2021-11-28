shader_type canvas_item;

uniform float process_value: hint_range(0, 1) = 0.0;

uniform float shiny_size : hint_range(-1, 1) = -0.1;
uniform float shiny_smooth_light : hint_range(0, 1) = 0.25;
uniform float shiny_intensity : hint_range(0, 5) = 0.75;
uniform float shiny_angle: hint_range(0, 180) = 100;

uniform float fade : hint_range(0.0, 1.0) = 1.0;


float mark_light(vec2 uv, float size, float _smooth_light, float _intensity, float _shiny_angle, float _process_value)
{
	uv = uv - vec2(_process_value, 0.5);
	float r = 3.1415;
	float angle = atan(uv.x, uv.y) - _shiny_angle * 0.0174533;
	float d = cos(floor(0.5 + angle / r) * r - angle) * length(uv);
	float dist = 1.0 - smoothstep(size, size + _smooth_light, d);
	return dist * _intensity;
}


void fragment()
{
	vec4 main_tex = texture(TEXTURE, UV);
	float mark_light = mark_light(UV, shiny_size, shiny_smooth_light, shiny_intensity, shiny_angle, process_value);
	vec4 output_color = vec4(main_tex.rgb + mark_light, main_tex.a);

	output_color.a *= fade;
	COLOR = output_color;
}
