tool
class_name SSDissolveDust extends SShaderInterval


export(float, -1, 1, 0.001) var offset_x: float = 0 setget _set_offset_x

# If you use this shader for Sprite ỏor RectTexure then offset_y value can be -0.85
# If you use this shader for Viewport then offset_y value can be -0.15
export(float, -1, 1, 0.001) var offset_y: float = -0.85 setget _set_offset_y

export(float, 1, 256, 0.5) var dust_size: float = 64 setget _set_dust_size

export(float, 0, 10, 0.01) var dust_value_x: float = 1 setget _set_dust_value_x
export(float, 0, 10, 0.01) var dust_value_y: float = 4 setget _set_dust_value_y


func _load_shader():
	return load(SHADER_FOLDER_BASE + "dissolve_dust.shader")


func _set_offset_x(value):
	offset_x = value
	_set_shader_f_value("offset_x", value)

func _set_offset_y(value):
	offset_y = value
	_set_shader_f_value("offset_y", value)

func _set_dust_size(value):
	var v = floor(value)
	dust_size = v
	_set_shader_f_value("dust_size", float(v))

func _set_dust_value_x(value):
	dust_value_x = value
	_set_shader_f_value("dust_value_x", value)

func _set_dust_value_y(value):
	dust_value_y = value
	_set_shader_f_value("dust_value_y", value)
