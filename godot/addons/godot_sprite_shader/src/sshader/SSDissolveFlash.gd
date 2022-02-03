tool
class_name SSDissolveFlash extends SShaderInterval

export(float, -1, 1, 0.001) var offset_x: float = 0.5 setget _set_offset_x
export(float, -1, 1, 0.001) var offset_y: float = 0.5 setget _set_offset_y

export(float, 0, 20, 0.05) var line_thickness: float = 2.0 setget _set_line_thickness
export var in_color: Color = Color.white setget _set_in_color
export var line_color: Color = Color(.35, .95, .9, 1.0) setget _set_line_color

func _load_shader():
	return load(SHADER_FOLDER_BASE + "dissolve_flash.shader")


func _set_offset_x(value):
	line_thickness = value
	_set_shader_f_value("offset_x", value)

func _set_offset_y(value):
	line_thickness = value
	_set_shader_f_value("offset_y", value)

func _set_line_thickness(value):
	line_thickness = value
	_set_shader_f_value("line_thickness", value)

func _set_in_color(value):
	in_color = value
	_set_shader_color_value("in_color", value)

func _set_line_color(value):
	line_color = value
	_set_shader_color_value("line_color", value)
