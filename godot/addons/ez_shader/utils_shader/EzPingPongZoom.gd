class_name EzPingPongZoom extends EzShader

export var zoom: float = 1.0 setget _set_zoom
export var center_x: float = 0.5 setget _set_center_x
export var center_y: float = 0.5 setget _set_center_y
export var intensity: float = 0.2 setget _set_intensity

export var speed: float = 1.0 setget _set_speed
export var smooth_value: float = 1.0 setget _set_smooth_value


func _load_shader():
	return load(SHADER_FOLDER_BASE + "pingpong_zoom.shader")


func _set_zoom(value):
	_set_shader_f_value("zoom", value, 0.1, 4.0)

func _set_center_x(value):
	_set_shader_f_value("center_x", value, -1, 2)

func _set_center_y(value):
	_set_shader_f_value("center_y", value, -1, 2)

func _set_intensity(value):
	_set_shader_f_value("intensity", value, 0, 1)

func _set_speed(value):
	_set_shader_f_value("speed", value, -10, 10)

func _set_smooth_value(value):
	_set_shader_f_value("smooth_value", value, 0, 1)


