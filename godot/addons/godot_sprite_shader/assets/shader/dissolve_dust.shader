shader_type canvas_item;

uniform sampler2D noise_tex;
uniform float offset_x : hint_range(-1, 1) = 0;
uniform float offset_y : hint_range(-1, 1) = -0.85;
uniform float dust_size : hint_range(1, 512) = 128;
uniform float dust_value_x : hint_range(0, 10) = 1.0;
uniform float dust_value_y : hint_range(0, 10) = 4.0;
uniform float process_value : hint_range(0, 1) = 0.0;


vec2 rotate(vec2 n, float angle)
{
	return mat2(vec2(cos(angle), -sin(angle)), vec2(sin(angle), cos(angle))) * n;
}


vec2 displacement_rotative_uv(vec2 uv, vec4 noise, float v, float a)
{
	return mix(uv, uv + rotate(vec2(noise.r - 0.5, noise.r - 0.5), a * 3.1415926), v);
}


vec2 resize_uv_clamp(vec2 uv, float offsetx, float offsety, float x, float y)
{
	uv += vec2(offsetx, offsety);
	uv = fract(clamp(uv * vec2(x*x, y*y), 0.0001, 0.9999));
	return uv;
}


vec2 pixel_uv(vec2 uv, float _pixel_size)
{
	return floor(uv * _pixel_size + 0.5) / _pixel_size;
}


void fragment()
{
	vec2 resize_uv = resize_uv_clamp(UV, offset_x, offset_y, dust_value_x, dust_value_y);
	vec2 dust_uv = pixel_uv(UV, dust_size);
	vec4 noise = texture(noise_tex, dust_uv);
	vec2 uv = displacement_rotative_uv(resize_uv, noise, 0.3, 0.23);
	uv = mix(UV, uv, process_value);

	vec4 output_color = texture(TEXTURE, uv);
	COLOR = output_color;
}
