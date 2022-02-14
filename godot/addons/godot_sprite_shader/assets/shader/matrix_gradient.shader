shader_type canvas_item;

uniform int direction = 0;
uniform float row : hint_range(1.0, 100.0) = 12.0;
uniform float column : hint_range(1.0, 100.0) = 12.0;
uniform float matrix_value : hint_range(1, 25) = 20;
uniform sampler2D chars_tex;
uniform float number_row_char_texture = 3.0;
uniform float number_column_char_texture = 3.0;
uniform float line_thickness : hint_range(0, 20) = 5.0;


float rand1(vec2 co, float random_seed)
{
    return fract(sin(dot(co.xy * random_seed, vec2(12.,85.5))) * 120.01);
}

vec3 randomColor (int indexColumn) 
{
	float f = float(indexColumn);
	float red = rand1(vec2(f, 1.0), f) * 0.8;
	float blue = rand1(vec2(f, 1.0), f + 1.0) * 0.5;
	float green = rand1(vec2(f, 1.0), f + 2.0);
	return vec3(red, blue, green);
}

float rand2_with_range(vec2 co, float m, float M, float random_seed)
{
	float r1 = rand1(co, random_seed);
	return (M - m) * r1 + r1;
}

vec3 rain(vec2 uv, float _matrix_value, float number_row, float number_column, int di, float time)
{
	float column_size = 1.0 / number_column;
	float row_size = 1.0 / number_row;
	
	float x = uv.x - mod(uv.x, column_size);
	float offset = sin(x * 15.0);
	float speed = cos(x * 3.0) * 0.3 + 0.7;
	
	float y =  uv.y - mod(uv.y, row_size);
	y = (di > 0) ? fract(y + time * speed + offset) : fract(1.0 - y + time * speed + offset);
	float alpha = 1.0 / ((26.0 - _matrix_value) * y);
	
	vec3 color = randomColor(int(uv.x *  number_column)); 
	color *= alpha;
	return color;
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
	vec3 rain = rain(UV, matrix_value, floor(row), floor(column), direction, TIME);
	float text = text(UV, floor(row), floor(column), TIME);
	vec3 matrix = text * rain;
	vec4 txt = texture(TEXTURE, UV);
	
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	float _outline = texture(TEXTURE, UV + vec2(0, -size.y)).a;
	_outline += texture(TEXTURE, UV + vec2(0, -size.y * 2.0)).a;
	_outline += texture(TEXTURE, UV + vec2(0, -size.y * 3.0)).a;
	_outline += texture(TEXTURE, UV + vec2(0, -size.y * 4.0)).a;
	_outline += texture(TEXTURE, UV + vec2(0, -size.y * 5.0)).a;
	_outline += texture(TEXTURE, UV + vec2(size.x, 0)).a;
	_outline += texture(TEXTURE, UV + vec2(-size.x, 0)).a;
	_outline= min(1.0, _outline) - txt.a;
	
	float v = matrix.r + matrix.g + matrix.b;
	if (v > 1.0)
	{
		float have_char = min(1.0, v);
		vec4 outline_matrix = vec4(matrix, 1.0 * text);
		txt = mix(txt, outline_matrix, _outline);
		txt.rgb = mix(txt.rgb, matrix, have_char);
	}
	
	vec4 output_color = txt;
	COLOR = output_color;
}
