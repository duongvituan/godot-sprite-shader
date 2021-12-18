tool
class_name EzTransformGhost extends EzShaderInterval

export var fill_color: Color = Color(0.92, 0.9, 0.88, 1) setget _set_fill_color


func _load_shader():
	return load(SHADER_FOLDER_BASE + "transform_ghost.shader")


func _set_fill_color(value):
	_set_shader_color_value("fill_color", value)
