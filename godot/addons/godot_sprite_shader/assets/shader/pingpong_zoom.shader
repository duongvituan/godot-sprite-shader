shader_type canvas_item;


uniform float offset: hint_range(0, 100) = 0;
uniform float speed : hint_range(-10, 10) = 1;
uniform float zoom : hint_range(0.1 , 4.0) = 1.0;
uniform float center_x : hint_range(-1.0 , 2.0) = 0.5;
uniform float center_y : hint_range(-1.0 , 2.0) = 0.5;
uniform float intensity : hint_range(0, 1.0) = 0.2;
uniform float smooth_value : hint_range(0.0 , 1.0) = 1.0;
uniform float fade : hint_range(0.0, 1.0) = 1.0;


vec2 zoom_uv(vec2 uv, float _zoom, float posx, float posy, float _intensity, float value)
{
	vec2 center = vec2(posx, posy);
	uv -= center;
	_zoom += sin(value) * _intensity * 0.5;
	uv = uv * _zoom;
	uv += center;
	return uv;
}

void fragment()
{
	float value = offset + TIME * speed * 7.5;
	vec2 uv = zoom_uv(UV, zoom, center_x, center_y, intensity, value);
	uv = mix(UV, uv, vec2(smooth_value));
	vec4 output_color = texture(TEXTURE, uv);

	output_color.a *= fade;
	COLOR = output_color;
}
