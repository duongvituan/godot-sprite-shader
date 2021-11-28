class_name EzShader extends Node


const SHADER_FOLDER_BASE = "res://addons/ez_shader/shader/2d/"

export var fade: float = 1.0 setget _set_fade

var shader_meterial: ShaderMaterial
var node_use_shader = null


var ease_func_value = null
var time_func = null


var inactive_when_finished: bool = false
var repeat_forever: bool = false
var repeat: int = 1
var delay_each_repeat: float = 0
var _repeat_count: int = 0
var _current_delay_each_repeat_time: float = 0


var duration: float = 0.0	
var _current_time: float = 0.0
var _old_eased_value: float = 0.0


var is_active: bool = false setget _set_active


### BUILD IN ENGINE METHODS =====================

func _init():
	shader_meterial = ShaderMaterial.new()
	shader_meterial.shader = _load_shader()


func _ready():
	set_process(false)
	if node_use_shader == null:
		node_use_shader = _auto_find_node_use_shader()


func _process(delta):
	if (not is_instance_valid(node_use_shader)) or duration <= 0.0:
		_finished()
		return
	
	if node_use_shader.material != shader_meterial:
		_finished()
		return
	
	_current_time += delta
	if _current_time > duration:
		# final frame call update
		_update_ease_in(duration, duration + delta - _current_time)
		_reset_time_value()
		_check_repeat_or_finish()
		return
	_update_ease_in(_current_time, delta)
### ===============================================================


### PUBLIC METHODS ==========================================

func play(duration: float, inactive_when_finished: bool = false):
	self.inactive_when_finished = inactive_when_finished
	self.repeat = 1
	self.duration = duration
	self.is_active = true
	_reset()
	set_process(true)


func play_repeat(duration: float, repeat: int, inactive_when_finished: bool = false, delay_each_repeat: float = 0.0):
	self.inactive_when_finished = inactive_when_finished
	self.delay_each_repeat = delay_each_repeat
	self.repeat = repeat
	self.duration = duration
	self.is_active = true
	_reset()
	set_process(true)


func play_repeat_forever(duration: float, delay_each_repeat: float = 0.0):
	self.duration = duration
	self. delay_each_repeat = delay_each_repeat
	self.repeat_forever = true
	self.is_active = true
	_reset()
	set_process(true)
### ===============================================================


### PRIVATE METHODS ==========================================
func _valid_node_use_shader(node) -> bool:
	return node is Sprite \
		or node is TextureRect \
		or node is ViewportContainer


# If node_use_shader not set then EzNode will auto find it.
# This func find valid node in all parent of EzNode or all node same level with EzNode 
func _auto_find_node_use_shader() -> Node:
	# find valid node with parrent ezNode
	var node = self
	while true:
		if _valid_node_use_shader(node):
			return node
		
		node = node.get_parent()
		if node == null:
			break
	
	# find valid node in same level with ez node:
	for child_node in self.get_parent().get_children():
		if _valid_node_use_shader(child_node):
			return child_node
			
	print("_auto_find_node_use_shader: can't find valid node use shader")
	return null


func _check_repeat_or_finish():
	if repeat_forever:
		return
		
	_repeat_count += 1
	if _repeat_count >= repeat:
		_finished()


func _finished():
	set_process(false)
	if inactive_when_finished:
		self.is_active = false


func _update_ease_in(value: float, delta: float):
	if ease_func_value != null:
		var eased_value = ease(value / duration, ease_func_value)
		_update(eased_value * duration, eased_value, (eased_value - _old_eased_value) * duration)
		_old_eased_value = eased_value

	elif time_func != null:
		var eased_value = time_func.interpolate(value / duration)
		_update(eased_value * duration, eased_value, (eased_value - _old_eased_value) * duration)
		_old_eased_value = eased_value

	else:
		_update(value, value / duration, delta)



func _reset_time_value():
	self._current_time = 0
	self._old_eased_value = 0


func _reset():
	_reset_time_value()
	_repeat_count = 0


### VIRTUAL FUNC ================================================

func _load_shader():
	pass


# value: 0.0 -> duration
# eased_value: 0.0 -> 1.0
# delta: new_value - old_value
func _update(value: float, eased_value: float, delta: float):
	pass



### CONFIG SETGET FUNC ==========================================

func _set_shader_f_value(name_value, value, _min = -99999999.0, _max = 99999999.0):
	var valid_value = clamp(value, _min, _max)
	shader_meterial.set_shader_param(name_value, valid_value)


func _set_shader_color_value(name_value, color):
	shader_meterial.set_shader_param(name_value, color)


func _set_fade(value: float):
	_set_shader_f_value("fade", value, 0, 1)


func _set_active(value: bool):
	is_active = value
	if value:
		node_use_shader.material = shader_meterial
	else:
		node_use_shader.material = null
### ===============================================================
