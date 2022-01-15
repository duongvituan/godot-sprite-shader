tool
class_name EzHoloWave extends EzShader

export(float, 0, 100, 0.1) var offset: float = 0.0 setget _set_offset
export(float, -10, 10, 0.01) var speed: float = 1.0 setget _set_speed

export(float, 0, 1, 0.001) var wave_height: float = 0.12 setget _set_wave_height
export(float, 0, 20, 0.01) var wave_speed: float = 3 setget _set_wave_speed
export(float, 0, 100, 0.1) var wave_freq: float = 30.0 setget _set_wave_freq
export(float, 0, 10, 0.001) var wave_width: float = 1.0 setget _set_wave_width

export var tint_color: Color = Color(0, 0.65, 1, 1) setget _set_tint_color


func _load_shader():
	return load(SHADER_FOLDER_BASE + "holo_wave.shader")


func _set_offset(value):
	offset = value
	_set_shader_f_value("offset", value)

func _set_speed(value):
	speed = value
	_set_shader_f_value("speed", value)

func _set_wave_height(value):
	wave_height = value
	_set_shader_f_value("wave_height", value)

func _set_wave_speed(value):
	wave_speed = value
	_set_shader_f_value("wave_speed", value)

func _set_wave_freq(value):
	wave_freq = value
	_set_shader_f_value("wave_freq", value)

func _set_wave_width(value):
	wave_width = value
	_set_shader_f_value("wave_width", value)

func _set_tint_color(value):
	tint_color = value
	_set_shader_color_value("tint_color", value)

