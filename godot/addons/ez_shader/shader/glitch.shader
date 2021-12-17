shader_type canvas_item;

uniform vec4 tint_color : hint_color = vec4(0.0, 0.65, 1, 1);
uniform float blend_value : hint_range(0.0, 1.0) = 1.0;
uniform float speed: hint_range(0.0, 10.0) = 1.0;
uniform float size : hint_range(0.0, 10.0) = 0.75;
uniform float amount : hint_range(0.0, 24.0) = 10.0;
uniform float process_value : hint_range(0.0, 1.0) = 0.0;
uniform float fade : hint_range(0.0, 1.0) = 1.0;


float rand1(vec2 co, float random_seed)
{
    return fract(sin(dot(co.xy * random_seed, vec2(12.,85.5))) * 120.01);
}


float rand2(vec2 co, float random_seed)
{
    float r1 = fract(sin(dot(co.xy * random_seed ,vec2(12.9898, 78.233))) * 43758.5453);
    return fract(sin(dot(vec2(r1 + co.xy * 1.562) ,vec2(12.9898, 78.233))) * 43758.5453);
}


vec4 glitch(vec2 uv, sampler2D source, float glitch_size, float glitch_amount, float _speed, float value)
{	
	float seed = floor(value * _speed * 10.0) / 10.0;
	vec2 blockS = floor(uv * vec2 (24., 19.) * glitch_size) * 4.0;
	vec2  blockL = floor(uv * vec2 (38., 14.) * glitch_size) * 4.0;

	float line_noise = pow(rand2(blockS, seed), 3.0) * glitch_amount * pow(rand2(blockL, seed), 3.0);
	vec4 color = texture(source, uv + vec2 (line_noise * 0.02 * rand1(vec2(2.0), seed), 0));
	return color;
}

vec4 blend_color(vec4 txt, vec4 color, float value)
{
	vec3 tint = vec3(dot(txt.rgb, vec3(.22, .7, .07)));
	tint.rgb *= color.rgb;
	txt.rgb = mix(txt.rgb, tint.rgb, value);
	return txt;
}

void fragment() 
{
	vec4 glitch = glitch(UV, TEXTURE, size, amount, speed, process_value);
	vec4 tint = blend_color(glitch, tint_color, blend_value);
	vec4 final_result = tint;
	
	final_result.a = final_result.a * fade;
	COLOR = final_result;
}
