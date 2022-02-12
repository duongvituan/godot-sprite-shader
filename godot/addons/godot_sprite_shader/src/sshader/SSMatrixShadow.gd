tool
class_name SSMatrixShadow extends SShader

export(int) var direction = 0 setget _set_dicrection
export(float, 1, 128, 0.5) var row: float = 16.0 setget _set_row
export(float, 1, 128, 0.5) var column: float = 16.0 setget _set_column
export(float, 1.0, 25.0, 0.1) var matrix_value: float = 10.0 setget _set_matrix_value

# This is row and column characters of texture, for this chars_texture16x16.png is 16x16 character
# If you change chars_tex, you need to change number_row_char_texture and number_column_char_texture
export(int, 1, 128) var number_row_char_texture: int = 16 setget _set_number_row_char_texture
export(int, 1, 128) var number_column_char_texture: int = 16 setget _set_number_column_char_texture

export var tint_color: Color = Color(0, 1, 0, 1.0) setget _set_tint_color
export var chars_tex = preload("res://addons/godot_sprite_shader/assets/noise/chars_texture16x16.png") setget _set_chars_tex

func _load_shader():
	return load(SHADER_FOLDER_BASE + "matrix_shadow.shader")


func _ready():
	self.chars_tex = chars_tex

func _set_dicrection(value):
	direction = value
	_set_shader_f_value("direction", value)

func _set_row(value):
	var v = floor(value)
	row = v
	_set_shader_f_value("row", v)

func _set_column(value):
	var v = floor(value)
	column = v
	_set_shader_f_value("column", v)

func _set_chars_tex(value):
	chars_tex = value
	_set_shader_texture_value("chars_tex", value)

func _set_tint_color(value):
	tint_color = value
	_set_shader_color_value("tint_color", value)

func _set_matrix_value(value):
	matrix_value = value
	_set_shader_f_value("matrix_value", value)


func _set_number_row_char_texture(value):
	number_row_char_texture = value
	_set_shader_f_value("number_row_char_texture", float(value))

func _set_number_column_char_texture(value):
	number_column_char_texture = value
	_set_shader_f_value("number_column_char_texture", float(value))
