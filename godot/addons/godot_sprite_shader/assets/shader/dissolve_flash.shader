shader_type canvas_item;

uniform float process_value : hint_range(0, 1) = 0;
uniform float fade : hint_range(0.0, 1.0) = 1.0;

uniform float offset_x : hint_range(-1, 1) = 0.5;
uniform float offset_y : hint_range(-1, 1) = 0.5;

uniform vec4 in_color : hint_color = vec4(1);
uniform vec4 line_color : hint_color = vec4(0.35, 0.95, .9, 1.0);
uniform float line_thickness : hint_range(0, 20) = 2.0;


vec4 transform_suck(sampler2D sampler, vec2 uv, float value)
{
	vec2 offset = vec2(offset_x, offset_y);
	float l = length(offset - uv);
	
	vec2 v = uv - offset;
	v /= smoothstep(0.0, 1.0, min(1.0, value * 10.0 * sqrt(l)));
	v += offset;
	
	return texture(sampler, v);
}


vec4 dissolve_vfx(sampler2D sampler, vec2 uv, vec4 _line_color, vec4 _in_color, vec2 size, float value)
{
	float v = smoothstep(0.0, 1.0, (1.0 - value) * 2.0);
	vec2 outline_size = vec2(0.0, 0.0);
	outline_size = mix(outline_size, size, vec2(v));
	
	vec4 txt = transform_suck(sampler, uv, value);
	float l = transform_suck(sampler, uv + vec2(-outline_size.x, 0), value).a;
	float u = transform_suck(sampler, uv + vec2(0, outline_size.y), value).a;
	float r = transform_suck(sampler, uv + vec2(outline_size.x, 0), value).a;
	float d = transform_suck(sampler, uv + vec2(0, -outline_size.y), value).a;
	float lu = transform_suck(sampler, uv + vec2(-outline_size.x, outline_size.y), value).a;
	float ru = transform_suck(sampler, uv + vec2(outline_size.x, outline_size.y), value).a;
	float ld = transform_suck(sampler, uv + vec2(-outline_size.x, -outline_size.y), value).a;
	float rd = transform_suck(sampler, uv + vec2(outline_size.x, -outline_size.y), value).a;

	float outline = min(1.0, l + r + u + d + lu + ru + ld + rd) - txt.a;
	float inline = (1.0 - l * r * u * d * lu * ru * rd * ld) * txt.a;
	float rim = outline + inline;
	if (1.0 - value < 0.01)
	{
		rim = 0.0;
	}

	float mix_color_body_value = smoothstep(0.0, 1.0, (1.0 - value) * 5.0);
	txt.rbg = mix(txt.rbg, _in_color.rbg, vec3(mix_color_body_value));
	txt = mix(txt, _line_color, rim);
	return txt;
}


void fragment()
{
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	vec4 output_color = dissolve_vfx(TEXTURE, UV, line_color, in_color, size, 1.0 - process_value);

	output_color.a *= fade;
	COLOR = output_color;
}
