tool
class_name EzMatrix extends EzShader

export var chars_tex = preload("res://addons/ez_shader/noise/chars_texture.png") setget _set_chars_tex
export var tint_color: Color = Color(0, 1, 0, 1.0) setget _set_tint_color
export(float, 1, 128, 0.5) var block_size: float = 16.0 setget _set_block_size
export(float, 0.0, 10.0, 0.01) var maxtrix_value: float = 8.5 setget _set_maxtrix_value

func _load_shader():
	return load(SHADER_FOLDER_BASE + "matrix1.shader")


func _ready():
	self.chars_tex = chars_tex

func _set_chars_tex(value):
	chars_tex = value
	_set_shader_texture_value("chars_tex", value)

func _set_tint_color(value):
	tint_color = value
	_set_shader_color_value("tint_color", value)

func _set_block_size(value):
	var v = floor(value)
	block_size = v
	_set_shader_f_value("block_size", v)

func _set_maxtrix_value(value):
	maxtrix_value = value
	_set_shader_f_value("maxtrix_value", value)
