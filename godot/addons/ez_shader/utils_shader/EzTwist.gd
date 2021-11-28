class_name EzTwist extends EzShader

export var bend: float = 1.0 setget _set_bend
export var offset_x: float = 0.5 setget _set_offset_x
export var offset_y: float = 0.5 setget _set_offset_y
export var ratius: float = 0.5 setget _set_ratius
export var speed: float = 1.0 setget _set_speed
export var smooth_value: float = 8.0 setget _set_smooth_value

func _load_shader():
	return load(SHADER_FOLDER_BASE + "twist.shader")


func _set_bend(value):
	_set_shader_f_value("bend", value, -2, 2)

func _set_offset_x(value):
	_set_shader_f_value("offset_x", value, -1, 2)

func _set_offset_y(value):
	_set_shader_f_value("offset_y", value, -1, 2)

func _set_ratius(value):
	_set_shader_f_value("ratius", value, 0, 1)

func _set_speed(value):
	_set_shader_f_value("speed", value, -20, 20)

func _set_smooth_value(value):
	_set_shader_f_value("smooth_value", value, 0, 11)

