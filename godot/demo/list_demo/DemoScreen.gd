class_name DemoScreen extends Node2D

func get_name() -> String:
	return "Demo"


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		click_screen(get_global_mouse_position())


func click_screen(position):
	print(position)
