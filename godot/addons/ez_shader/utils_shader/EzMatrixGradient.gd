tool
class_name EzMatrixGradient extends EzShader

export(int) var direction = 0 setget _set_dicrection
export(float, 1, 128, 0.5) var row: float = 12.0 setget _set_row
export(float, 1, 128, 0.5) var column: float = 12.0 setget _set_column
export(float, 0.0, 10.0, 0.01) var maxtrix_value: float = 8.5 setget _set_maxtrix_value
export(float, 0.0, 20.0, 0.01) var line_thickness: float = 5.0 setget _set_line_thickness

export(int, 1, 128) var number_row_char_texture: int = 3 setget _set_number_row_char_texture
export(int, 1, 128) var number_column_char_texture: int = 3 setget _set_number_column_char_texture

export var chars_tex = preload("res://addons/ez_shader/noise/char_9x9.png") setget _set_chars_tex

func _load_shader():
	return load(SHADER_FOLDER_BASE + "matrix_gradient.shader")


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

func _set_maxtrix_value(value):
	maxtrix_value = value
	_set_shader_f_value("maxtrix_value", value)

func _set_line_thickness(value):
	line_thickness = value
	_set_shader_f_value("line_thickness", value)

func _set_number_row_char_texture(value):
	number_row_char_texture = value
	_set_shader_f_value("number_row_char_texture", float(value))

func _set_number_column_char_texture(value):
	number_column_char_texture = value
	_set_shader_f_value("number_column_char_texture", float(value))
