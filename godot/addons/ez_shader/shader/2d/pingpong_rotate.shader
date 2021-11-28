shader_type canvas_item;


uniform float angle_start : hint_range(-360.0 , 360.0) = 0.0;
uniform float angle_arc : hint_range(0.0 , 720.0) = 60.0;

uniform float center_x : hint_range(-2.0 , 2.0) = 0.5;
uniform float center_y : hint_range(-2.0 , 2.0) = 0.5;
uniform float speed : hint_range(-30.0 , 30.0) = 5.0;
uniform float smooth_value : hint_range(0.0 , 1.0) = 1.0;
uniform float fade : hint_range(0.0, 1.0) = 1.0;


vec2 rotate(vec2 n, float angle)
{
	return mat2(vec2(cos(angle), -sin(angle)), vec2(sin(angle), cos(angle))) * n;
}


vec2 rotation_uv(vec2 uv, float angleStart, float centerX, float centerY, float angleArc, float _speed, float time)
{
	uv = uv - vec2(centerX, centerY);
	float angle = angleStart * 0.01745329;
	angle += sin(time * _speed) * angleArc * 0.01745329 * 0.5;
	return rotate(uv, angle) + vec2(centerX, centerY);
}

void fragment()
{
	vec2 uv = rotation_uv(UV, angle_start, center_x, center_y, angle_arc, speed, TIME);
	uv = mix(UV, uv, vec2(smooth_value));
	vec4 output_color = texture(TEXTURE, uv);

	output_color.a *= fade;
	COLOR = output_color;
}
