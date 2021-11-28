class_name EzDoodle extends EzShader

export var doodle_size: float = 8.0 setget _set_doodle_size
export var doodle_speed: float = 8.0 setget _set_doodle_speed
export var doodle_intensity: float = 8.0 setget _set_doodle_intensity
export var smooth_value: float = 8.0 setget _set_smooth_value

func _load_shader():
	return load(SHADER_FOLDER_BASE + "doodle.shader")


func _set_doodle_size(value):
	_set_shader_f_value("doodle_size", value, 2, 16)

func _set_doodle_speed(value):
	_set_shader_f_value("doodle_speed", value, 2, 16)

func _set_doodle_intensity(value):
	_set_shader_f_value("doodle_intensity", value, 1, 100)

func _set_smooth_value(value):
	_set_shader_f_value("smooth_value", value, 0, 11)

