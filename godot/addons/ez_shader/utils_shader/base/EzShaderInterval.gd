class_name EzShaderInterval extends EzShader

export(float, 0, 1, 0.001) var process_value: float = 0.0 setget _set_process_value


func _set_process_value(value):
	process_value = value
	_set_shader_f_value("process_value", value)


func _update(value: float, eased_value: float, delta: float):
	self.process_value = eased_value
