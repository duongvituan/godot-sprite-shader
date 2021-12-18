shader_type canvas_item;

uniform float process_value : hint_range(0.0, 1.0) = 0.0;
uniform float offset : hint_range(-1 , 1) = 0;
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
	float value = process_value * 2.0;
	vec4 main_tex = texture(TEXTURE, UV);
	vec4 color = burn_color(main_tex, offset, burn_value, value);
	vec4 final_result = color;

	final_result.a *= fade;
	COLOR = final_result;
}
