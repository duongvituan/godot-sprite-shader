tool
class_name SSPingPongZoom extends SShader

export(float, 0, 100, 0.1) var offset: float = 0.0 setget _set_offset
export(float, -10, 10, 0.01) var speed: float = 1.0 setget _set_speed
export(float, 0.1, 4, 0.01) var zoom: float = 1.0 setget _set_zoom
export(float, -1, 2, 0.001) var center_x: float = 0.5 setget _set_center_x
export(float, -1, 2, 0.001) var center_y: float = 0.5 setget _set_center_y
export(float, 0, 2, 0.001) var intensity: float = 0.2 setget _set_intensity
export(float, 0, 1, 0.001) var smooth_value: float = 1.0 setget _set_smooth_value


func _load_shader():
	return load(SHADER_FOLDER_BASE + "pingpong_zoom.shader")

func _set_offset(value):
	offset = value
	_set_shader_f_value("offset", value)

func _set_speed(value):
	speed = value
	_set_shader_f_value("speed", value)

func _set_zoom(value):
	zoom = value
	_set_shader_f_value("zoom", value)

func _set_center_x(value):
	center_x = value
	_set_shader_f_value("center_x", value)

func _set_center_y(value):
	center_y = value
	_set_shader_f_value("center_y", value)

func _set_intensity(value):
	intensity = value
	_set_shader_f_value("intensity", value)

func _set_smooth_value(value):
	smooth_value = value
	_set_shader_f_value("smooth_value", value)


