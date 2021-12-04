tool
class_name EzDissolveCircle extends EzShaderInterval

export(float, -1, 1, 0.001) var center_x: float = 0.5 setget _set_center_x
export(float, -1, 1, 0.001) var center_y: float = 0.5 setget _set_center_y
export var tint_color: Color = Color.white setget _set_tint_color

func _load_shader():
	return load(SHADER_FOLDER_BASE + "dissolve_circle.shader")


func _set_center_x(value):
	center_x = value
	_set_shader_f_value("center_x", value)

func _set_center_y(value):
	center_y = value
	_set_shader_f_value("center_y", value)

func _set_tint_color(value):
	tint_color = value
	_set_shader_color_value("tint_color", value)
