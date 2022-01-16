shader_type canvas_item;

uniform vec4 line_color : hint_color = vec4(1);
uniform float line_thickness : hint_range(0, 20) = 3.0;
uniform float fade : hint_range(0.0, 1.0) = 1.0;


float outline(vec2 uv, sampler2D txt, vec2 size) {
	float outline = texture(txt, uv + vec2(-size.x, 0)).a;
	outline += texture(txt, uv + vec2(0, size.y)).a;
	outline += texture(txt, uv + vec2(size.x, 0)).a;
	outline += texture(txt, uv + vec2(0, -size.y)).a;
	outline += texture(txt, uv + vec2(-size.x, size.y)).a;
	outline += texture(txt, uv + vec2(size.x, size.y)).a;
	outline += texture(txt, uv + vec2(-size.x, -size.y)).a;
	outline += texture(txt, uv + vec2(size.x, -size.y)).a;
	outline = min(outline, 1.0);
	return outline;
}

void fragment()
{
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	float outline_value = outline(UV, TEXTURE, size);
	vec4 color = texture(TEXTURE, UV);
	vec4 output_color = mix(color, line_color, outline_value - color.a);

	output_color.a *= fade;
	COLOR = output_color;
}