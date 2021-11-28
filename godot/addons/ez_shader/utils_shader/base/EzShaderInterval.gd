class_name EzShaderInterval extends EzShader

export var process_value: float = 0.0 setget _set_process_value

func _set_process_value(value):
	_set_shader_f_value("process_value", value, 0, 1)

func _update(value: float, eased_value: float, delta: float):
	self.process_value = eased_value
