extends EditorInspectorPlugin

var ex_view = preload("./extension_view.tscn")

func can_handle(object):
	return (object is Node2D) or (object is Control)

func parse_end():
	var view = ex_view.instance()
	add_custom_control(view)
