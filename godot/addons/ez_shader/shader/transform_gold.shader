shader_type canvas_item;

uniform float speed : hint_range(-10, 10) = 1;
uniform float sprite_fade : hint_range(0.0, 1.0) = 1.0;


// Approximates luminance from an RGB value
float calc_luminance(vec3 color)
{
    return dot(color, vec3(0.2126, 0.7152, 0.0721));
}

float mark_light(vec2 uv, float _speed, float _time)
{
	vec2 co = uv * 5.0;
	float v = _time * _speed;
	float n = sin(v + co.x) + sin(v - co.x) + sin(v + co.y) + sin(v + 2.5 * co.y);
	return fract((5.0 + n) / 5.0);
}


vec4 transform_gold(vec2 uv, sampler2D txt, float _speed, float _time)
{
	vec4 txt_color = texture(txt, uv);
	float luminance = calc_luminance(txt_color.rbg);
	vec3 metal = vec3(luminance);
	metal.r = luminance * pow(1.5 * luminance, 8.0);
	metal.g = luminance * pow(1.5 * luminance, 8.0);
	metal.b = luminance * pow(0.75 * luminance, 8.0);
	
	vec2 co = uv * 2.5;
	float v = _time * _speed * 1.5;
	float n = mark_light(uv, _speed, _time);
	n += dot(txt_color.rbg, vec3(0.2, 0.4, 0.2));
	n = fract(n);
	
	float a = clamp(abs(n * 6.0 - 2.0), 0.0, 1.0);
	vec4 color = vec4(metal.rgb + (1.0 - a), 1.0);
	color.rgb = color.rgb * 0.5 + dot(color.rgb, vec3 (0.113, 0.455, 0.172)) - vec3(0.0, 0.1, 0.6) + 0.025;
	color.a = txt_color.a;
	return color; 
}


void fragment()
{
	vec4 transform_gold = transform_gold(UV, TEXTURE, speed, TIME);
	vec4 output_color = transform_gold;

	output_color.a *= sprite_fade;
	COLOR = output_color;
}


