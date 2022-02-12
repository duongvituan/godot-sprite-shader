tool
class_name SSDoodle extends SShader

export(float, 2, 16, 0.01) var doodle_size: float = 8.0 setget _set_doodle_size
export(float, 2, 16, 0.01) var doodle_speed: float = 8.0 setget _set_doodle_speed
export(float, 1, 100, 0.1) var doodle_intensity: float = 8.0 setget _set_doodle_intensity
export(float, 0, 1, 0.001) var smooth_value: float = 1.0 setget _set_smooth_value

func _load_shader():
	return load(SHADER_FOLDER_BASE + "doodle.shader")


func _set_doodle_size(value):
	doodle_size = value
	_set_shader_f_value("doodle_size", value)

func _set_doodle_speed(value):
	doodle_speed = value
	_set_shader_f_value("doodle_speed", value)

func _set_doodle_intensity(value):
	doodle_intensity = value
	_set_shader_f_value("doodle_intensity", value)

func _set_smooth_value(value):
	smooth_value = value
	_set_shader_f_value("smooth_value", value)
