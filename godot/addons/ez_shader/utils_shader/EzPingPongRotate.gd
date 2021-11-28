class_name EzPingPongRotate extends EzShader

export var angle_arc: float = 60 setget _set_angle_arc
export var center_x: float = 0.5 setget _set_center_x
export var center_y: float = 0.5 setget _set_center_y
export var speed: float = 5.0 setget _set_speed
export var smooth_value: float = 1.0 setget _set_smooth_value


func _load_shader():
	return load(SHADER_FOLDER_BASE + "pingpong_rotate.shader")


func _set_angle_arc(value):
	_set_shader_f_value("angle_arc", value, 0, 720)

func _set_center_x(value):
	_set_shader_f_value("center_x", value, -2, 2)

func _set_center_y(value):
	_set_shader_f_value("center_y", value, -2, 2)


func _set_speed(value):
	_set_shader_f_value("speed", value, -30, 30)

func _set_smooth_value(value):
	_set_shader_f_value("smooth_value", value, 0, 1)


