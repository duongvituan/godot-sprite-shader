shader_type canvas_item;

uniform float offset: hint_range(0, 100) = 0;
uniform float speed : hint_range(-10, 10) = 1;
uniform float range_x : hint_range(-2.0 , 2.0) = 0.1;
uniform float range_y : hint_range(-2.0 , 2.0) = 0.0;
uniform float zoom_x : hint_range(0.1 , 10.0) = 1.0;
uniform float zoom_y : hint_range(0.1 , 10.0) = 1.0;
uniform float smooth_value : hint_range(0.0 , 1.0) = 1.0;

vec2 pingpong_offset_uv(vec2 uv, float _range_x, float _range_y, float zoomx, float zoomy, float value)
{
	uv += vec2(_range_x, _range_y) * sin(value);
	uv = uv / vec2(zoomx, zoomy);
	return uv;
}


void fragment()
{
	float value = offset + TIME * speed * 7.5;
	vec2 uv = pingpong_offset_uv(UV, range_x, range_y, zoom_x, zoom_y, value);
	uv = mix(UV, uv, vec2(smooth_value));
	vec4 output_color = texture(TEXTURE, uv);
	COLOR = output_color;
}
