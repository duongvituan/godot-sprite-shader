shader_type canvas_item;

uniform vec4 color : hint_color = vec4(1);
uniform float fade : hint_range(0.0, 1.0) = 1.0;


vec4 mix_color(vec4 txt, vec4 _color)
{
	txt.rgb = mix(txt.rgb, _color.rgb, _color.a);
	return txt;
}

void fragment()
{
	vec4 output_color = mix_color(texture(TEXTURE, UV), color);

	output_color.a *= fade;
	COLOR = output_color;
}