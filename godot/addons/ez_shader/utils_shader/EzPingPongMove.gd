class_name EzPingPongMove extends EzShader

export var range_x: float = 0.1 setget _set_range_x
export var range_y: float = 0.0 setget _set_range_y
export var zoom_x: float = 1.0 setget _set_zoom_x
export var zoom_y: float = 1.0 setget _set_zoom_y
export var speed: float = 1.0 setget _set_speed
export var smooth_value: float = 1.0 setget _set_smooth_value


func _load_shader():
	return load(SHADER_FOLDER_BASE + "pingpong_move.shader")


func _set_range_x(value):
	_set_shader_f_value("range_x", value, -2, 2)

func _set_range_y(value):
	_set_shader_f_value("range_y", value, -2, 2)

func _set_zoom_x(value):
	_set_shader_f_value("zoom_x", value, 0.1, 10)

func _set_zoom_y(value):
	_set_shader_f_value("zoom_y", value, 0.1, 10)

func _set_speed(value):
	_set_shader_f_value("speed", value, -10, 10)

func _set_smooth_value(value):
	_set_shader_f_value("smooth_value", value, 0, 1)


