tool
class_name SSOneColor extends SShader

export var color: Color = Color.white setget _set_color


func _load_shader():
	return load(SHADER_FOLDER_BASE + "one_color.shader")


func _set_color(value):
	color = value
	_set_shader_color_value("color", value)
