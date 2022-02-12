tool
class_name SSTwist extends SShader

export(float, -2, 2, 0.001) var bend: float = 1.0 setget _set_bend
export(float, -1, 2, 0.001) var offset_x: float = 0.5 setget _set_offset_x
export(float, -1, 2, 0.001) var offset_y: float = 0.5 setget _set_offset_y
export(float, 0, 1, 0.001) var ratius: float = 0.5 setget _set_ratius
export(float, -10, 10, 0.01) var speed: float = 1.0 setget _set_speed
export(float, 0, 1, 0.001) var smooth_value: float = 8.0 setget _set_smooth_value

func _load_shader():
	return load(SHADER_FOLDER_BASE + "twist.shader")


func _set_bend(value):
	bend = value
	_set_shader_f_value("bend", value)

func _set_offset_x(value):
	offset_x = value
	_set_shader_f_value("offset_x", value)

func _set_offset_y(value):
	offset_y = value
	_set_shader_f_value("offset_y", value)

func _set_ratius(value):
	ratius = value
	_set_shader_f_value("ratius", value)

func _set_speed(value):
	speed = value
	_set_shader_f_value("speed", value)

func _set_smooth_value(value):
	smooth_value = value
	_set_shader_f_value("smooth_value", value)
