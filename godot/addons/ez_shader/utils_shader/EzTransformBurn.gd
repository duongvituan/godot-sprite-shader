tool
class_name EzTransfromBurn extends EzShaderInterval

export(float, -1, 1, 0.001) var offset: float = 1.0 setget _set_offset
export(float, 0, 1, 0.001) var burn_value: float = 1.0 setget _set_burn_value


func _load_shader():
	return load(SHADER_FOLDER_BASE + "transform_burn.shader")


func _set_offset(value):
	offset = value
	_set_shader_f_value("offset", value)

func _set_burn_value(value):
	burn_value = value
	_set_shader_f_value("burn_value", value)

