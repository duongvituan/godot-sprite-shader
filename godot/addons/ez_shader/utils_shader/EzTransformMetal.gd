tool
class_name EzTransformMetal extends EzShader

export(float, -10, 10, 0.01) var speed: float = 1.0 setget _set_speed


func _load_shader():
	return load(SHADER_FOLDER_BASE + "transform_metal.shader")


func _set_speed(value):
	speed = value
	_set_shader_f_value("speed", value)


