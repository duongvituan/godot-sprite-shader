shader_type canvas_item;

uniform float offset_x : hint_range(-1, 1) = 0;
uniform float offset_y : hint_range(-1, 1) = -0.85;
uniform float dust_size : hint_range(1, 256) = 64;
uniform float process_value : hint_range(0, 1) = 0.45;
uniform float fade : hint_range(0.0, 1.0) = 1.0;


vec2 rotate(vec2 n, float angle)
{
	return mat2(vec2(cos(angle), -sin(angle)), vec2(sin(angle), cos(angle))) * n;
}


vec2 displacement_rotative_uv(vec2 uv, vec4 noise, float v1, float v2)
{
	return mix(uv, uv + rotate(vec2(noise.r - 0.5, noise.r -0.5), v2 * 3.1415926), v1);
}


vec2 resize_uv_clamp(vec2 uv, float offsetx, float offsety, float zoomx, float zoomy)
{
	uv += vec2(offsetx, offsety);
	uv = fract(clamp(uv * vec2(zoomx*zoomx, zoomy*zoomy), 0.0001, 0.9999));
	return uv;
}


vec4 generate_noise(vec2 uv)
{
	return vec4(fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453));
}


vec2 pixel_uv(vec2 uv, float _pixel_size)
{
	return floor(uv * _pixel_size + 0.5) / _pixel_size;
}


void fragment()
{
	vec2 resize_uv = resize_uv_clamp(UV, offset_x, offset_y, 1, 3);
	vec2 dust_uv = pixel_uv(UV, dust_size);
	vec4 noise = generate_noise(dust_uv);
	vec2 uv = displacement_rotative_uv(resize_uv, noise, 0.3, 0.234);
	uv = mix(UV, uv, process_value);

	vec4 output_color = texture(TEXTURE, uv);
	output_color.a *= fade;
	COLOR = output_color;
}
