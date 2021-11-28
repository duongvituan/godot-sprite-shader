class_name EzOutline extends EzShader

export var line_color: Color = Color.white setget _set_line_color
export var line_thickness: float = 3.0 setget _set_line_thickness


func _load_shader():
	return load(SHADER_FOLDER_BASE + "outline.shader")


func _set_line_color(value):
	_set_shader_color_value("line_color", value)


func _set_line_thickness(value):
	_set_shader_f_value("line_thickness", value, 0, 20)

