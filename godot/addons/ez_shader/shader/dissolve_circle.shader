shader_type canvas_item;

uniform float center_x : hint_range(-2, 2.0) = 0.5;
uniform float center_y : hint_range(-2, 2.0) = 0.5;
uniform vec4 tint_color : hint_color = vec4(1);
uniform float process_value : hint_range(0, 1) = 0;
uniform float fade : hint_range(0.0, 1.0) = 1.0;


vec4 circle_fade(vec4 txt, vec2 uv, float posX, float posY, vec4 color, float value)
{
	vec2 center = vec2(posX, posY);
	float r = smoothstep(0, value, length(center - uv));
	vec4 output = txt;
	output.a *= 1.0 - r;
	output.rgb = mix(txt.rgb, color.rgb * 5.0, (1.0 - r) * (1.0 - r));
	return mix(txt, output, 1.0 - value);
}


void fragment()
{
	vec4 output_color = circle_fade(texture(TEXTURE, UV), UV, center_x, center_y, tint_color, 1.0 - process_value);

	output_color.a *= fade;
	COLOR = output_color;
}
