shader_type canvas_item;

uniform float process_value : hint_range(0.0, 1.0) = 0.0;

vec2 rotate(vec2 n, float angle)
{
	return mat2(vec2(cos(angle), -sin(angle)), vec2(sin(angle), cos(angle))) * n;
}

vec4 dissolve_twist(vec2 uv, sampler2D sampler, float value)
{
	uv -= 0.5;
    float v = pow(max(0., -0.2 + mod(value, 1.2)), 3.);
    float r1 = length(uv);
    float r2 = r1 + v;
    float angle = v / r1;
    uv = (r2 / r1) * rotate(uv, angle) + 0.5;
    return texture(sampler, uv);
}

void fragment()
{
	vec4 output_color = dissolve_twist(UV, TEXTURE, process_value);
	COLOR = output_color;
}
