tool
class_name SSShinyFx extends SShaderInterval

enum Direction { LEFT_TO_RIGHT, RIGHT_TO_LEFT, SWING }

export(int, 0, 2) var direction = Direction.SWING

export(float, -1, 1, 0.001) var shiny_size: float = -0.1 setget _set_shiny_size
export(float, 0, 1, 0.001) var shiny_smooth_light: float = 0.25 setget _set_shiny_smooth_light
export(float, 0, 5, 0.01) var shiny_intensity: float = 0.75 setget _set_shiny_intensity



func _load_shader():
	return load(SHADER_FOLDER_BASE + "shiny.shader")

func _set_shiny_size(value):
	shiny_size = value
	_set_shader_f_value("shiny_size", value)

func _set_shiny_smooth_light(value):
	shiny_smooth_light = value
	_set_shader_f_value("shiny_smooth_light", value)

func _set_shiny_intensity(value):
	shiny_intensity = value
	_set_shader_f_value("shiny_intensity", value)


func _update(value: float, eased_value: float, delta: float):
	var process_value = eased_value
	if direction == Direction.LEFT_TO_RIGHT:
		process_value = eased_value
	elif direction == Direction.RIGHT_TO_LEFT:
		process_value = 1.0 - eased_value
	elif direction == Direction.SWING:
		if eased_value <= 0.5:
			process_value = eased_value * 2.0
		else:
			process_value = 2.0 - eased_value * 2.0
	self.process_value = process_value
