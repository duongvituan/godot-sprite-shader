shader_type canvas_item;

uniform float offset: hint_range(0, 100) = 0;
uniform float speed : hint_range(-10, 10) = 1;

uniform float wave_height : hint_range(0, 1) = 0.12;
uniform float wave_speed: hint_range(0, 20) = 3;
uniform float wave_freq: hint_range(0, 100) = 30.0;
uniform float wave_width: hint_range(0, 10) = 1.0;

uniform vec4 tint_color : hint_color = vec4(0, 0.65, 1, 1);
uniform float fade : hint_range(0.0, 1.0) = 1.0;


float mark(vec2 uv, float height, float time)
{
	float value = mod(uv.y - time * 0.5, 2.0);
	return (value < height) ? 1.0 : 0.0;
}

vec4 holo(vec2 uv, sampler2D sampler ,float _wave_speed, float _wave_freq, float _wave_width, float _wave_height, float time)
{
	vec2 wave_uv_offset = vec2(0, 0);
	wave_uv_offset.x = sin(time * _wave_speed + uv.y * _wave_freq * 2.0) * uv.y * uv.y * _wave_width * 0.1;
	float mark_value = mark(uv, _wave_height, time);
	uv = (mark_value > 0.0) ? uv + wave_uv_offset : uv;
	return texture(sampler, uv);
}

vec4 flash_color(vec4 txt, vec4 color, vec2 uv, float time)
{
	vec3 tint = vec3(dot(txt.rgb, vec3(.2, .7, .1)));
	tint.rgb *= color.rgb;
	float x = abs(sin(time * 2.0)) * (1.0 - uv.y) + (1.0 - uv.y) * 0.8 + 0.2;
	txt.rgb = mix(txt.rgb, tint.rgb, x);
	return txt;
}

void fragment() {
	float time = offset + TIME * speed;
	vec4 holo = holo(UV, TEXTURE, wave_speed, wave_freq, wave_width, wave_height, time);
	vec4 output_color = flash_color(holo, tint_color, UV, time);
	output_color.a *= fade;
	COLOR = output_color;
}