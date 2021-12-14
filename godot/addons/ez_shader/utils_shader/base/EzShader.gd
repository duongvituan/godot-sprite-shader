class_name EzShader extends Node


const SHADER_FOLDER_BASE = "res://addons/ez_shader/shader/"

export(NodePath) var node_path setget _set_node_path
export(bool) var is_active = false setget _set_active
export(float, 0, 1, 0.001) var fade: float = 1.0 setget _set_fade


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
var is_reverse: bool = false


var duration: float = 0.0	
var _current_time: float = 0.0
var _old_eased_value: float = 0.0



### BUILD IN ENGINE METHODS ====================================================

func _init():
	shader_meterial = ShaderMaterial.new()
	shader_meterial.shader = _load_shader()

func _enter_tree():
	if node_use_shader == null:
		node_use_shader = _auto_find_node_use_shader()
		if node_use_shader != null:
			node_path = node_use_shader.get_path()


func _ready():
	set_process(false)


func _process(delta):
	if (not is_instance_valid(node_use_shader)) or duration <= 0.0:
		_finished()
		return
	
	if node_use_shader.material != shader_meterial:
		_finished()
		return
	
	if _current_delay_each_repeat_time > 0:
		_current_delay_each_repeat_time -= delta
		if _current_delay_each_repeat_time >= 0:
			return
		else:
			delta = abs(_current_delay_each_repeat_time)
	
	_current_time += delta
	if _current_time > duration:
		# final frame call update
		_update_value_if_need(duration, duration + delta - _current_time)
		_reset_time_value()
		_check_repeat_or_finish()
		return
	_update_value_if_need(_current_time, delta)

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
	if repeat > 0:
		self.repeat = repeat
	else:
		self.repeat_forever = true
	self.delay_each_repeat = delay_each_repeat
	self.is_reverse = is_reverse
	self.inactive_when_finished = inactive_when_finished
	
	self.is_active = true
	_reset()
	set_process(true)


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
	_current_delay_each_repeat_time = delay_each_repeat
	if repeat_forever:
		return
		
	_repeat_count += 1
	if _repeat_count >= repeat:
		_finished()


func _finished():
	set_process(false)
	if inactive_when_finished:
		self.is_active = false


func _update_value_if_need(raw_value: float, raw_delta: float):
	var value = raw_value
	var eased_value = raw_value / self.duration
	var delta = raw_delta
	
	if ease_func_value != null:
		eased_value = ease(eased_value, ease_func_value)
		value = eased_value * self.duration
		delta = (eased_value - self._old_eased_value) * self.duration
		self._old_eased_value = eased_value
	
	elif time_func != null:
		eased_value = time_func.interpolate(eased_value)
		value = eased_value * self.duration
		delta = (eased_value - self._old_eased_value) * self.duration
		self._old_eased_value = eased_value
	
	if self.is_reverse:
		value = self.duration - value
		eased_value = 1.0 - eased_value
	
	_update(value, eased_value, delta)


func _reset_time_value():
	self._current_time = 0
	self._old_eased_value = 0


func _reset():
	_reset_time_value()
	_current_delay_each_repeat_time = 0
	_repeat_count = 0


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


func _set_node_path(path: NodePath):
	var node = get_node(path)
	if node != null:
		node_use_shader = node
		node_path = path

func _set_active(value: bool):
	is_active = value
	if value:
		node_use_shader.material = shader_meterial
	elif node_use_shader.material == shader_meterial:
		node_use_shader.material = null

### ============================================================================
