tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("ss", "res://addons/godot_sprite_shader/ss.gd")


func _exit_tree():
	remove_autoload_singleton ("ss")
