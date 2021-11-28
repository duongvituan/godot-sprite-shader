class_name EzTransfromGold extends EzShader

export var speed: float = 1.0 setget _set_speed


func _load_shader():
	return load(SHADER_FOLDER_BASE + "transform_gold.shader")


func _set_speed(value):
	_set_shader_f_value("speed", value, -10, 10)


