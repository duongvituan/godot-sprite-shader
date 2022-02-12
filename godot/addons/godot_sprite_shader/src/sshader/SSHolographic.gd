tool
class_name SSHolographic extends SShader

export var tint_color: Color = Color(0, 0.65, 1, 1) setget _set_tint_color
export(float, 0, 1, 0.001) var hologram_value: float = 0.75 setget _set_hologram_value
export(float, 0, 20, 0.1) var hologram_noise_x: float = 10 setget _set_hologram_noise_x
export(float, 0, 4, 0.01) var hologram_speed: float = 0.75 setget _set_hologram_speed


func _load_shader():
	return load(SHADER_FOLDER_BASE + "holographic.shader")


func _set_tint_color(value):
	tint_color = value
	_set_shader_color_value("tint_color", value)


func _set_hologram_value(value):
	hologram_value = value
	_set_shader_f_value("hologram_value", value)

func _set_hologram_noise_x(value):
	hologram_noise_x = value
	_set_shader_f_value("hologram_noise_x", value)

func _set_hologram_speed(value):
	hologram_speed = value
	_set_shader_f_value("hologram_speed", value)
