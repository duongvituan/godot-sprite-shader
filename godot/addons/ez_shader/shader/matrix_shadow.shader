shader_type canvas_item;

uniform int direction = 0;
uniform float row : hint_range(1.0, 100.0) = 16.0;
uniform float column : hint_range(1.0, 100.0) = 16.0;
uniform float matrix_value : hint_range(1, 25) = 10;
uniform float fade : hint_range(0.0, 1.0) = 1.0;

uniform vec4 tint_color : hint_color = vec4(0.0, 1.0, 0.0, 1.0);
uniform sampler2D chars_tex;
uniform float number_row_char_texture = 16.0;
uniform float number_column_char_texture = 16.0;


float rand2(vec2 co, float random_seed)
{
    float r1 = fract(sin(dot(co.xy * random_seed ,vec2(12.9898, 78.233))) * 43758.5453);
    return fract(sin(dot(vec2(r1 + co.xy * 1.562) ,vec2(12.9898, 78.233))) * 43758.5453);
}

float rand2_with_range(vec2 co, float m, float M, float random_seed)
{
	float r1 = rand2(co, random_seed);
	return (M - m) * r1 + r1;
}

vec3 rain(vec2 uv, vec4 color, float value, float number_row, float number_column, int di, float time)
{
	float column_size = 1.0 / number_column;
	float row_size = 1.0 / number_row;
	
	float column_id = uv.x - mod(uv.x, column_size);
	float offset = sin(column_id * 15.0);
	float speed = cos(column_id * 3.0) * 0.3 + 0.7;
	
	float row_id =  uv.y - mod(uv.y, row_size);
	float y = (di > 0) ? fract(row_id + time * speed + offset) : fract(1.0 - row_id + time * speed + offset);
	return tint_color.rgb * (1.0 / ((26.0 - matrix_value) * y));
}

vec2 randomIndexChar(vec2 char_size, vec2 blockID, float time)
{
	vec2 indexChar = vec2(0, 0);
	float t = time - mod(time, 0.1);
	float r1 = rand2_with_range(blockID / char_size + t, 1, char_size.x, 1);
	indexChar.x = blockID.x + char_size.x * r1;
	indexChar.y = blockID.y + char_size.y * r1;
	
	indexChar = mod(floor(indexChar), char_size);
	return indexChar;
}

float text(vec2 uv, float number_row, float number_column, float time)
{
	float column_size = 1.0 / number_column;
	float row_size = 1.0 / number_row;
	vec2 block_size = vec2(column_size, row_size);

	vec2 blockID = floor(uv / block_size);
	vec2 _uv = mod(uv.xy, block_size) / block_size;

	vec2 char_texture_size = vec2(number_row_char_texture, number_column_char_texture);
	vec2 index_char = randomIndexChar(char_texture_size, blockID, time);
	_uv.y = 1.0 - _uv.y;
	_uv = (index_char + _uv) / char_texture_size;

	return texture(chars_tex, _uv).r;
}

void fragment() {
	vec3 rain = rain(UV, tint_color, matrix_value, floor(row), floor(column), direction, TIME);
	float text = text(UV, floor(row), floor(column), TIME);
	vec3 matrix = text * rain;
	vec4 txt = texture(TEXTURE, UV);
	txt.rgb = matrix;
	
	vec4 output_color = txt;
	output_color.a *= fade;
	COLOR = output_color;
}
