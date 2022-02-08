tool
extends VBoxContainer

enum Type {Create, Update}

onready var title_label := $ColorRect/Label
onready var ok_button := $Button
onready var line_edit_width := $HBoxContainer/LineEdit
onready var line_edit_height := $HBoxContainer2/LineEdit

var type = Type.Create


func _ready():
	$Button.connect("button_down", self, "_on_button_down")
	configUI()


func configUI():
	if type == Type.Create:
		title_label.text = "GSShader Extension:\n Use Viewport to your Node"
		ok_button.text = "OK"
		
	elif type == Type.Update:
		title_label.text = "GSShader Extension:\n Update size Viewport"
		ok_button.text = "Update"
		
		var selection = _get_selected()
		if selection is ViewportContainer:
			line_edit_width.text = str(selection.rect_size.x)
			line_edit_height.text = str(selection.rect_size.y)


func _get_selected() -> Node:
	var ep = EditorPlugin.new()
	var selected = ep.get_editor_interface().get_selection().get_selected_nodes()
	
	if selected.size():
		return selected[0]
	return null


func _on_button_down():
	var size = Vector2(
		float(line_edit_width.text),
		float(line_edit_height.text)
	)
	
	if size.x <= 0.0:
		push_error("Current width is: %s, width must be greater than zero" % size.x)
		return
	
	if size.y <= 0.0:
		push_error("Current height is: %s, height must be greater than zero" % size.y)
		return
	
	if type == Type.Create:
		add_node_to_viewport(size)
	elif type == Type.Update:
		update_size_viewport(size)


func _set_owner_node_and_children(node, root):
	node.set_owner(root)
	for child in node.get_children():
		_set_owner_node_and_children(child, root)


func add_node_to_viewport(size: Vector2):
	var root = get_tree().get_edited_scene_root()
	var selection = _get_selected()

	if root == selection:
		push_error("Can not use viewport on Root Node")
		return
	
	var viewport_container = ViewportContainer.new()
	selection.get_parent().add_child(viewport_container)
	viewport_container.set_owner(root)
	
	var viewport = Viewport.new()
	viewport_container.add_child(viewport)
	viewport.set_owner(root)
	viewport.transparent_bg = true
	viewport.own_world = true
	
#	When using keywork "tool"
#	selection.get_parent().remove_child(selection) <-------- raise error: core/object.cpp:1958
#	I will duplication node and add it again :((.
	var new_node = selection.duplicate()
	selection.queue_free()
	
	viewport.add_child(new_node)
	_set_owner_node_and_children(new_node, root)
	
	var center = Vector2.ZERO
	
	if new_node is Node2D:
		center = new_node.position
		new_node.position = size / 2.0
		
	elif new_node is Control:
		center = new_node.rect_position + new_node.rect_size / 2.0
		new_node.rect_position = (size - new_node.rect_size) / 2.0
	
	viewport.size = size
	viewport_container.rect_position = center - size / 2.0
	viewport_container.rect_min_size = size
	viewport_container.rect_size = size


func update_size_viewport(size: Vector2):
	var selection = _get_selected()
	
	var is_valid = selection is ViewportContainer \
		&& selection.get_child_count() > 0 \
		&& selection.get_child(0) is Viewport
	
	if not is_valid:
		return
	
	var viewport_container: ViewportContainer = selection
	var viewport = viewport_container.get_child(0)
	 
	var old_center_position = viewport_container.rect_position + viewport_container.rect_size / 2.0
	
	viewport.size = size
	viewport_container.rect_position = old_center_position - size / 2.0
	viewport_container.rect_min_size = size
	viewport_container.rect_size = size

	if viewport.get_child_count() == 0:
		return
	
	var node = viewport.get_child(0)

	if node is Node2D:
		node.position = size / 2.0

	elif node is Control:
		var center = node.rect_position + node.rect_size / 2.0
		node.rect_position = (size - node.rect_size) / 2.0
