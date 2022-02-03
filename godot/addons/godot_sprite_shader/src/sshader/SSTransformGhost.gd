tool
class_name SSTransformGhost extends SShader

export(float, 0, 100, 0.1) var offset: float = 0.0 setget _set_offset
export(float, -10, 10, 0.01) var speed: float = 1.0 setget _set_speed
export var fill_color: Color = Color(0.92, 0.9, 0.88, 1) setget _set_fill_color


func _load_shader():
	return load(SHADER_FOLDER_BASE + "transform_ghost.shader")

func _set_offset(value):
	offset = value
	_set_shader_f_value("offset", value)

func _set_speed(value):
	speed = value
	_set_shader_f_value("speed", value)

func _set_fill_color(value):
	_set_shader_color_value("fill_color", value)
