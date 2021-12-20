tool
class_name EzShaderPlayer extends Node


export(NodePath) var node_path = null setget _set_node_path

var node_use_shader = null
var activating_shader = null
var animating_shader = null

var _is_ready = false


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

func _ready():
	set_process(false)
	_is_ready = true
	
	if node_path == null:
		_auto_find_node_use_shader()
	
	elif node_path != null:
		self.node_use_shader = get_node(node_path)
	
	_check_first_active_shader()


func _process(delta):
	if activating_shader == null:
		set_process(false)
		return
	
	if (not is_instance_valid(node_use_shader)) or duration <= 0.0:
		_finished()
		return
	
	if node_use_shader.material != animating_shader.shader_meterial:
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
		activating_shader._update_value_if_need(duration, duration + delta - _current_time)
		_reset_time_value()
		_check_repeat_or_finish()
		return
	activating_shader._update_value_if_need(_current_time, delta)


### ============================================================================

### PUBLIC METHODS =============================================================
### ============================================================================


### PRIVATE METHODS ============================================================

# warning-ignore:shadowed_variable
func _play(node_shader, duration: float, repeat: int, delay_each_repeat: float, is_reverse: bool, inactive_when_finished: bool):
	set_process(false)
	self.duration = duration
	if repeat > 0:
		self.repeat = repeat
	else:
		self.repeat_forever = true
	self.delay_each_repeat = delay_each_repeat
	self.is_reverse = is_reverse
	self.inactive_when_finished = inactive_when_finished
	
	node_shader.is_active = true
	animating_shader = node_shader
	_reset()
	set_process(true)
	


func _reset_time_value():
	self._current_time = 0
	self._old_eased_value = 0


func _reset():
	_reset_time_value()
	_current_delay_each_repeat_time = 0
	_repeat_count = 0


func _check_repeat_or_finish():
	_current_delay_each_repeat_time = delay_each_repeat
	if repeat_forever:
		return
		
	_repeat_count += 1
	if _repeat_count >= repeat:
		_finished()


func _finished():
	set_process(false)
	
	if node_use_shader.material != animating_shader.shader_meterial:
		return
	
	animating_shader = null
	
	if inactive_when_finished:
		self.activating_shader.is_active = false


func _valid_node_use_shader(node) -> bool:
	return node is Sprite \
		or node is TextureRect \
		or node is ViewportContainer


# If node_use_shader not set then EzNode will auto find it. (it return "/root/EditorNode/@@..")
# This func find valid node in all parent of EzNode or all node same level with EzNode 
func _auto_find_node_use_shader():
	# Humm, func get_path() not working well with Node use "tool",
	# So I find node path with code. :((
	var path = ""
	var node = null
	
	# find valid node use shader in same level with ez_shader:
	for child_node in self.get_parent().get_children():
		if _valid_node_use_shader(child_node):
			path = "../%s" % child_node.name
			node = child_node
			break
	
	if path == "":
		# try to find valid node with parrent of ez_shader
		var check_node = self
	
		var check_path = ""
		while true:
			if _valid_node_use_shader(check_node):
				path = check_path
				node = check_node
				break
				
			check_path += "../"
			check_node = check_node.get_parent()
			if check_node == null:
				break
	
	if node != null and path != "":
		self.node_use_shader = node
		self.node_path = path
	else:
		print("_auto_find_node_use_shader: can't find valid node use shader")


func _check_first_active_shader():
	for shader_node in get_children():
		if shader_node.is_active:
			_update_shader_active(shader_node, true)
			break

### ============================================================================

### CONFIG SETGET FUNC =========================================================

func _set_node_path(path: NodePath):
	node_path = path
	if path == null or not self._is_ready:
		return
	
	var node = get_node(path)
	
	if node != null:
		node_use_shader = node
	else:
		node_path = null


func _update_shader_active(ez_shader, is_active):
	
	if ez_shader == null or node_use_shader == null: # Error
		return
	
	# On
	if activating_shader == null and is_active == true:
		activating_shader = ez_shader
		node_use_shader.material = activating_shader.shader_meterial
		activating_shader._set_active(true, false)
		return
	
	# Off
	if activating_shader == ez_shader and is_active == false:
		activating_shader._set_active(false, false)
		activating_shader = null
		node_use_shader.material = null
		return
	
	# Switch active to other shader
	if is_active:
		activating_shader._set_active(false, false)
		activating_shader = ez_shader
		node_use_shader.material = activating_shader.shader_meterial
		activating_shader._set_active(true, false)

### ============================================================================

