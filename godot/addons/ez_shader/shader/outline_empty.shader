shader_type canvas_item;

uniform vec4 line_color : hint_color = vec4(1);
uniform float line_thickness : hint_range(0, 20) = 3.0;
uniform float fade : hint_range(0.0, 1.0) = 1.0;


vec4 empty_outline(vec2 uv, sampler2D txt, vec2 size, vec4 _line_color) {
	vec4 outline = texture(txt, uv + vec2(-size.x, 0));
	outline += texture(txt, uv + vec2(0, size.y));
	outline += texture(txt, uv + vec2(size.x, 0));
	outline += texture(txt, uv + vec2(0, -size.y));
	outline += texture(txt, uv + vec2(-size.x, size.y));
	outline += texture(txt, uv + vec2(size.x, size.y));
	outline += texture(txt, uv + vec2(-size.x, -size.y));
	outline += texture(txt, uv + vec2(size.x, -size.y));

	outline.rgb = _line_color.rbg;
	if (outline.a > 0.5) { outline = _line_color; }
	if (texture(txt, uv).a > 0.5) { outline.a = 0.0; }
	return outline;
}


void fragment()
{
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	vec4 outline_empty = empty_outline(UV, TEXTURE, size, line_color);
	vec4 output_color = outline_empty;
	
	output_color.a *= fade;
	COLOR = output_color;
}