shader_type canvas_item;

uniform float offset: hint_range(0, 100) = 0;
uniform float speed : hint_range(-10, 10) = 1;
uniform float offset_burn : hint_range(-1 , 1) = 0;
uniform float burn_value : hint_range(0 , 1) = 1;
uniform float fade : hint_range(0.0, 1.0) = 1.0;


vec4 burn_color(vec4 tx, float _offset, float _burn_value, float value)
{
	float gray = (tx.r + tx.g + tx.b) / 3.0;
	gray += _offset + value;
	vec4 color = tx;
	color.r = 1.0  + 0.4 * sin(6.28318 * gray);
	color.g = 0.9 * sin(3.14159 * gray);
	color.b = 0.1;
	color.rgb = mix(tx.rgb, color.rgb, _burn_value);
	return color;
}

void fragment()
{
	float value = offset + TIME * speed;
	vec4 main_tex = texture(TEXTURE, UV);
	vec4 color = burn_color(main_tex, offset_burn, burn_value, value);
	vec4 output_color = color;

	output_color.a *= fade;
	COLOR = output_color;
}
