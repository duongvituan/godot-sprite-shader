extends EditorInspectorPlugin

var ex_view = preload("./extension_view.tscn")

func can_handle(object):
	return object is ViewportContainer

func parse_end():
	var view = ex_view.instance()
	view.type = 1 # Type.Update
	add_custom_control(view)
