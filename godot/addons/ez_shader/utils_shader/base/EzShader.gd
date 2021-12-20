class_name EzShader extends Node


const SHADER_FOLDER_BASE = "res://addons/ez_shader/shader/"

export(bool) var is_active = false setget _set_active
export(float, 0, 1, 0.001) var fade: float = 1.0 setget _set_fade

var _shader_player: EzShaderPlayer setget , _get_shader_player

var shader_meterial: ShaderMaterial

var ease_func_value = null
var time_func = null

var is_reverse: bool = false
var duration: float = 0.0	


var _old_eased_value: float = 0.0

### BUILD IN ENGINE METHODS ====================================================

func _init():
	shader_meterial = ShaderMaterial.new()
	shader_meterial.shader = _load_shader()


func _get_configuration_warning():
	var warnings = PoolStringArray()
	if not self._shader_player:
		warnings.append("%s must be a child of EzShaderPlayer" % name)
	return warnings.join("\n")


### ============================================================================


### PUBLIC METHODS =============================================================

func play(duration: float, inactive_when_finished: bool = false):
	_play(duration, 1, 0, false, inactive_when_finished)


func play_repeat(duration: float, repeat: int, inactive_when_finished: bool = false, delay_each_repeat: float = 0.0):
	_play(duration, repeat, delay_each_repeat, false, inactive_when_finished)


func play_repeat_forever(duration: float, delay_each_repeat: float = 0.0):
	_play(duration, -1, delay_each_repeat, false, false)


func play_reverse(duration: float, inactive_when_finished: bool = false):
	_play(duration, 1, 0, true, inactive_when_finished)


func play_reverse_repeat(duration: float, repeat: int, inactive_when_finished: bool = false, delay_each_repeat: float = 0.0):
	_play(duration, repeat, delay_each_repeat, true, inactive_when_finished)


func play_reverse_repeat_forever(duration: float, delay_each_repeat: float = 0.0):
	_play(duration, -1, delay_each_repeat, false, false)


### ============================================================================


### PRIVATE METHODS ============================================================

func _play(duration: float, repeat: int, delay_each_repeat: float, is_reverse: bool, inactive_when_finished: bool):
	self.duration = duration
	self.is_reverse = is_reverse
	self._old_eased_value = 0
	
	var shader_player = self._shader_player
	if shader_player != null:
		shader_player._play(self, duration, repeat, delay_each_repeat, is_reverse, inactive_when_finished)


func _update_value_if_need(raw_value: float, raw_delta: float):
	if duration == 0:
		return
	
	var value = raw_value
	var eased_value = raw_value / duration
	var delta = raw_delta
	
	if ease_func_value != null:
		eased_value = ease(eased_value, ease_func_value)
		value = eased_value * duration
		delta = (eased_value - self._old_eased_value) * duration
		self._old_eased_value = eased_value
	
	elif time_func != null:
		eased_value = time_func.interpolate(eased_value)
		value = eased_value * duration
		delta = (eased_value - self._old_eased_value) * duration
		self._old_eased_value = eased_value
	
	if self.is_reverse:
		value = duration - value
		eased_value = 1.0 - eased_value
	
	_update(value, eased_value, delta)


### VIRTUAL FUNC ===============================================================

func _load_shader():
	pass


# value: 0.0 -> duration
# eased_value: 0.0 -> 1.0
# delta: new_value - old_value
func _update(value: float, eased_value: float, delta: float):
	pass



### CONFIG SETGET FUNC =========================================================

func _set_shader_f_value(name_value, value):
#	var valid_value = clamp(value, _min, _max)
	shader_meterial.set_shader_param(name_value, value)


func _set_shader_color_value(name_value, color):
	shader_meterial.set_shader_param(name_value, color)


func _set_shader_texture_value(name_value, texture):
	shader_meterial.set_shader_param(name_value, texture)


func _set_fade(value: float):
	fade = value
	_set_shader_f_value("fade", value)


func _get_shader_player():
	var parrent = get_parent()
	if parrent is EzShaderPlayer:
		return parrent
	return null


func _set_active(value: bool, need_callback: bool = true):
	is_active = value
	
	if not need_callback:
		return
	
	# Call back to Shader_Player to set activating node
	var shader_player = self._shader_player
	if shader_player != null:
		shader_player._update_shader_active(self, value)


### ============================================================================
