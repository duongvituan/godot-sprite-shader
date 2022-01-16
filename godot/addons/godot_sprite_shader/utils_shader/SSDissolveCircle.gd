tool
class_name SSDissolveCircle extends SShaderInterval

export(float, 0, 20, 0.05) var line_thickness: float = 2.0 setget _set_line_thickness
export var in_color: Color = Color.white setget _set_in_color
export var line_color: Color = Color(.35, .95, .9, 1.0) setget _set_line_color

func _load_shader():
	return load(SHADER_FOLDER_BASE + "dissolve_circle.shader")


func _set_line_thickness(value):
	line_thickness = value
	_set_shader_f_value("_set_line_thickness", value)


func _set_in_color(value):
	in_color = value
	_set_shader_color_value("in_color", value)

func _set_line_color(value):
	line_color = value
	_set_shader_color_value("line_color", value)
