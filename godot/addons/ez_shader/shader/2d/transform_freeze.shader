shader_type canvas_item;

uniform float speed : hint_range(-10, 10) = 1;
uniform float sprite_fade : hint_range(0.0, 1.0) = 1.0;


// Approximates luminance from an RGB value
float calc_luminance(vec3 color)
{
	return dot(color, vec3( 0.299, 0.587, 0.114));
}

vec4 shiny_fx(vec4 tx, vec2 uv, float size, float _smooth_light, float _intensity, float _shiny_angle, float _process_value)
{
	uv = uv - vec2(_process_value, 0.5);
	float r = 3.1415;
	float angle = atan(uv.x, uv.y) - _shiny_angle * 0.0174533;
	float d = cos(floor(0.5 + angle / r) * r - angle) * length(uv);
	float dist = 1.0 - smoothstep(size, size + _smooth_light, d);
	tx.rgb += dist * _intensity;
	return tx;
}


float mark_light(vec2 uv, float _speed, float _time, vec4 tx)
{
	vec2 co = uv * 5.0;
	float v = _time * _speed;
	float n = sin(v + co.x) + sin(v - co.x) + sin(v + co.y) + sin(v + 2.5 * co.y);
	n = fract((5.0 + n) / 5.0);
	return n;
}


vec4 transform_freeze(vec2 uv, sampler2D txt, float _speed, float _time)
{
	vec4 txt_color = texture(txt, uv);
	float luminance = calc_luminance(txt_color.rbg);
	vec3 metal = vec3(1.5 * luminance * luminance);
	
	float n = mark_light(uv, _speed, _time, txt_color);
	n += dot(txt_color.rbg, vec3(0.2, 0.4, 0.2));
	n = fract(n);
	
	float a = clamp(abs(n * 6.0 - 2.0), 0.0, 1.0);
	vec4 color = vec4(metal.rgb + (1.0 - a), 1.0);
	color.rgb = color.rgb * 0.5 + dot(color.rgb, vec3 (0.2, 0.5, 0.1)) - vec3(1.25, 0.5, 0.0);
	color.a = txt_color.a;
	return color;
}


void fragment() {
	vec4 transform_freeze = transform_freeze(UV, TEXTURE, speed, TIME);
	vec4 output_color = transform_freeze;

	output_color.a *= sprite_fade;
	COLOR = output_color;
}


