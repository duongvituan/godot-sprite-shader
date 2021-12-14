shader_type canvas_item;

uniform float speed : hint_range(-10, 10) = 1;
uniform float sprite_fade : hint_range(0.0, 1.0) = 1.0;


// Approximates luminance from an RGB value
float calc_luminance(vec3 color)
{
    return dot(color, vec3(0.4126, 0.8152, 0.1722));
}

float mark_light(vec2 uv, float _speed, float _time)
{
	vec2 co = uv * 5.0;
	float v = _time * _speed;
	float n = sin(v + co.x) + sin(v - co.x) + sin(v + co.y) + sin(v + 2.5 * co.y);
	return fract((5.0 + n) / 5.0);
}


vec4 transform_metal(vec2 uv, sampler2D txt, float _speed, float _time)
{
	vec4 txt_color = texture(txt, uv);
	float luminance = calc_luminance(txt_color.rgb);
	vec3 metal = vec3(luminance * pow(0.666 * luminance, 4.0));
	
	vec2 co = uv * 2.5;
	float v = _time * _speed * 1.5;
	float n = mark_light(uv, _speed, _time);
	n += dot(txt_color.rbg, vec3(0.2, 0.4, 0.2));
	n = fract(n);
	
	float a = clamp(abs(n * 6.0 - 2.0), 0.0, 1.0);
	vec4 color = vec4(metal.rgb + (1. - a), 1.0);
	color.rgb = 0.05 + color.rgb * 0.5 + dot(color.rgb, vec3 (0.2126, 0.2152, 0.1722)) * 0.5;
	color.a = txt_color.a;
	return color; 
}

void fragment()
{
	vec4 transform_metal = transform_metal(UV, TEXTURE, speed, TIME);
	vec4 output_color = transform_metal;

	output_color.a *= sprite_fade;
	COLOR = output_color;
}


