tool
extends EditorPlugin

var tool_create_plugin = preload("res://addons/godot_sprite_shader/src/tools/inspector_create_plugin.gd")
var tool_update_plugin = preload("res://addons/godot_sprite_shader/src/tools/inspector_update_plugin.gd")


func _enter_tree():
	add_autoload_singleton("ss", "res://addons/godot_sprite_shader/ss.gd")
	tool_create_plugin = tool_create_plugin.new()
	tool_update_plugin = tool_update_plugin.new()
	add_inspector_plugin(tool_update_plugin)
	add_inspector_plugin(tool_create_plugin)


func _exit_tree():
	remove_autoload_singleton ("ss")
	remove_inspector_plugin(tool_update_plugin)
	remove_inspector_plugin(tool_create_plugin)
