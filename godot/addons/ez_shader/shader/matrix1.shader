shader_type canvas_item;

uniform sampler2D chars_tex;

uniform float fade : hint_range(0.0, 1.0) = 1.0;
uniform vec4 tint_color : hint_color = vec4(0.0, 1.0, 0.0, 1.0);
uniform float matrix_value : hint_range(0, 10) = 8.5;
uniform float block_size = 24.0;

vec3 rain(vec2 fragCoord, vec2 uv, vec4 color, float value, float time)
{
	vec2 _fragCoord = fragCoord;
	_fragCoord.x -= mod(_fragCoord.x, block_size);
	float offset = sin(_fragCoord.x * 15.0);
	float speed = cos(_fragCoord.x * 3.0) * 0.3 + 0.7;
	
	float y = fract(1.0 - uv.y + time * speed + offset);
	float v =  10.0 * (10.0 - value) + 1.0;
	return tint_color.rgb * (1.0 / (v * y));
}

vec2 randomIndexChar(float char_size, vec2 blockID, float time)
{
	vec2 indexChar = vec2(0, 0);
	indexChar.x = blockID.x + char_size * abs(sin(time * 0.3) * 2.);
	indexChar.y = blockID.y + char_size * abs(cos(time * 0.3) * 3.);
	
	indexChar = mod(floor(indexChar), char_size);
	return indexChar;
}

float text(vec2 fragCoord, float time)
{
	vec2 _fragCoord = fragCoord.xy;
	vec2 uv = mod(_fragCoord.xy, block_size) / block_size;
	vec2 blockID = floor(_fragCoord / block_size);

	float max_size_char_texture = 16.0;
	vec2 index_char = randomIndexChar(max_size_char_texture, blockID, time) / max_size_char_texture;
	uv.y = 1.0 - uv.y;
	uv = index_char + uv / max_size_char_texture;

	return texture(chars_tex, uv).r;
}

void fragment() {
	vec3 rain = rain(FRAGCOORD.xy, UV, tint_color, matrix_value, TIME);
	float text = text(FRAGCOORD.xy, TIME);
	vec3 matrix = text * rain;
	vec4 txt = texture(TEXTURE, UV);
	txt.rgb = matrix;
	
	vec4 output_color = txt;
	output_color.a *= fade;
	COLOR = output_color;
}
