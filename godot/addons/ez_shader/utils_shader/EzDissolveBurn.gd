class_name EzDissolveBurn extends EzShaderInterval

export var noise_tex = preload("res://addons/ez_shader/noise/noise1.png") setget _set_noise_tex
export var burn_color: Color = Color(1, 0.3, 0.05, 1.0) setget _set_burn_color


func _load_shader():
	return load(SHADER_FOLDER_BASE + "dissolve_burn.shader")


func _ready():
	self.noise_tex = noise_tex

func _set_noise_tex(value):
	_set_shader_texture_value("noise_tex", value)

func _set_burn_color(value):
	_set_shader_color_value("burn_color", value)

