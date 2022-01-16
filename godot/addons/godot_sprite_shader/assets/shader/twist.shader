shader_type canvas_item;


uniform float bend : hint_range(-2.0 , 2.0) = 1.0;
uniform float offset_x : hint_range(-1.0 , 2.0) = 0.5;
uniform float offset_y : hint_range(-1.0 , 2.0) = 0.5;
uniform float ratius : hint_range(0.0 , 1.0) = 0.5;
uniform float speed : hint_range(-10.0 , 10.0) = 1.0;
uniform float smooth_value : hint_range(0.0 , 1.0) = 1.0;
uniform float fade : hint_range(0.0, 1.0) = 1.0;


vec2 rotate(vec2 n, float angle)
{
	return mat2(vec2(cos(angle), -sin(angle)), vec2(sin(angle), cos(angle))) * n;
}


vec2 twist_uv(vec2 uv, float _bend, float _offset_x, float _offset_y, float _radius, float _speed, float time)
{
	vec2 center = vec2(_offset_x, _offset_y);
	vec2 tc = uv - center;
	float dist = length(tc);
	if (dist < _radius)
	{
		float percent = (_radius - dist) / _radius;
		float angle = percent * percent * 8.0 * sin(_bend) + time * _speed * 2.0;
		tc = rotate(tc , angle);
	}
	tc += center;
	return tc;
}


void fragment()
{
	vec2 move_uv = twist_uv(UV, bend, offset_x, offset_y, ratius, speed, TIME);
	vec2 uv = mix(UV, move_uv, vec2(smooth_value));
	vec4 output_color = texture(TEXTURE, uv);

	output_color.a *= fade;
	COLOR = output_color;
}

