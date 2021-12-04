class_name EzTransfromBurn extends EzShader

export var offset: float = 1.0 setget _set_offset
export var burn_value: float = 1.0 setget _set_burn_value
export var speed: float = 1.0 setget _set_speed


func _load_shader():
	return load(SHADER_FOLDER_BASE + "transform_burn.shader")


func _set_offset(value):
	_set_shader_f_value("speed", value, -1, 1)

func _set_burn_value(value):
	_set_shader_f_value("speed", value, 0, 1)

func _set_speed(value):
	_set_shader_f_value("speed", value, -5, 5)


