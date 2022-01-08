tool
class_name EzGlitch extends EzShaderInterval

export(float, 0, 100, 0.1) var offset: float = 0.0 setget _set_offset
export(float, -10, 10, 0.01) var speed: float = 1.0 setget _set_speed
export(float, 0, 1, 0.001) var blend_value: float = 1.0 setget _set_blend_value
export(float, 0, 10, 0.01) var size: float = 0.75 setget _set_size
export(float, 0, 24, 0.01) var amount: float = 10.0 setget _set_amount

export var tint_color: Color = Color(0, 0.65, 1, 1) setget _set_tint_color

func _load_shader():
	return load(SHADER_FOLDER_BASE + "glitch.shader")

func _set_offset(value):
	offset = value
	_set_shader_f_value("offset", value)

func _set_speed(value):
	speed = value
	_set_shader_f_value("speed", value)

func _set_blend_value(value):
	blend_value = value
	_set_shader_f_value("blend_value", value)

func _set_size(value):
	size = value
	_set_shader_f_value("size", value)

func _set_amount(value):
	amount = value
	_set_shader_f_value("amount", value)

func _set_tint_color(value):
	tint_color = value
	_set_shader_color_value("tint_color", value)
