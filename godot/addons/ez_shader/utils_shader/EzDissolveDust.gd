class_name EzDissolveDust extends EzShaderInterval


export var offset_x: float = 0 setget _set_offset_x

# If you use this shader for Sprite ỏor RectTexure then offset_y value can be -0.85
# If you use this shader for Viewport then offset_y value can be -0.85
export var offset_y: float = -0.85 setget _set_offset_y

export var dust_size: float = 64 setget _set_dust_size


func _load_shader():
	return load(SHADER_FOLDER_BASE + "dissolve_dust.shader")


func _set_offset_x(value):
	_set_shader_f_value("offset_x", value, -1, 1)

func _set_offset_y(value):
	_set_shader_f_value("offset_y", value, -1, 1)

func _set_dust_size(value):
	_set_shader_f_value("dust_size", value, 1, 256)

