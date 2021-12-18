tool
class_name EzPingPongMove extends EzShaderInterval

export(float, -2, 2, 0.001) var range_x: float = 0.1 setget _set_range_x
export(float, -2, 2, 0.001) var range_y: float = 0.0 setget _set_range_y
export(float, 0.1, 10, 0.01) var zoom_x: float = 1.0 setget _set_zoom_x
export(float, 0.1, 10, 0.01) var zoom_y: float = 1.0 setget _set_zoom_y
export(float, 0, 1, 0.001) var smooth_value: float = 1.0 setget _set_smooth_value


func _load_shader():
	return load(SHADER_FOLDER_BASE + "pingpong_move.shader")


func _set_range_x(value):
	range_x = value
	_set_shader_f_value("range_x", value)

func _set_range_y(value):
	range_y = value
	_set_shader_f_value("range_y", value)

func _set_zoom_x(value):
	zoom_x = value
	_set_shader_f_value("zoom_x", value)

func _set_zoom_y(value):
	zoom_y = value
	_set_shader_f_value("zoom_y", value)

func _set_smooth_value(value):
	smooth_value = value
	_set_shader_f_value("smooth_value", value)


