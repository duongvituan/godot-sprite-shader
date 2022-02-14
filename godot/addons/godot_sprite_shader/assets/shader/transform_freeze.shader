shader_type canvas_item;

uniform float offset: hint_range(0, 100) = 0;
uniform float speed : hint_range(-10, 10) = 1;


// Approximates luminance from an RGB value
float calc_luminance(vec3 color)
{
	return dot(color, vec3( 0.299, 0.587, 0.114));
}


float mark_light(vec2 uv, float value)
{
	vec2 co = uv * 5.0;
	float n = sin(value + co.x) + sin(value - co.x) + sin(value + co.y) + sin(value + 2.5 * co.y);
	return fract((5.0 + n) / 5.0);
}


vec4 transform_freeze(vec2 uv, sampler2D txt, float value)
{
	vec4 txt_color = texture(txt, uv);
	float luminance = calc_luminance(txt_color.rbg);
	vec3 metal = vec3(1.5 * luminance * luminance);
	
	float n = mark_light(uv, value);
	n += dot(txt_color.rbg, vec3(0.2, 0.4, 0.2));
	n = fract(n);
	
	float a = clamp(abs(n * 6.0 - 2.0), 0.0, 1.0);
	vec4 color = vec4(metal.rgb + (1.0 - a), 1.0);
	color.rgb = color.rgb * 0.5 + dot(color.rgb, vec3 (0.2, 0.5, 0.1)) - vec3(1.25, 0.5, 0.0);
	color.a = txt_color.a;
	return color;
}


void fragment() 
{
	float value = offset + TIME * speed;
	vec4 transform_freeze = transform_freeze(UV, TEXTURE, value);
	vec4 output_color = transform_freeze;
	COLOR = output_color;
}
