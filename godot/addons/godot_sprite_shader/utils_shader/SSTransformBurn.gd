tool
class_name SSTransfromBurn extends SShader

export(float, 0, 100, 0.1) var offset: float = 0.0 setget _set_offset
export(float, -10, 10, 0.01) var speed: float = 1.0 setget _set_speed
export(float, -1, 1, 0.001) var offset_burn: float = 1.0 setget _set_offset_burn
export(float, 0, 1, 0.001) var burn_value: float = 1.0 setget _set_burn_value


func _load_shader():
	return load(SHADER_FOLDER_BASE + "transform_burn.shader")

func _set_offset(value):
	offset = value
	_set_shader_f_value("offset", value)

func _set_speed(value):
	speed = value
	_set_shader_f_value("speed", value)

func _set_offset_burn(value):
	offset = value
	_set_shader_f_value("offset_burn", value)

func _set_burn_value(value):
	burn_value = value
	_set_shader_f_value("burn_value", value)


