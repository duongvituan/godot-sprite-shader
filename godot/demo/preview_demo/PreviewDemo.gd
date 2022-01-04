extends Node2D

onready var demo_loader := $DemoLoader
onready var demo_container := $DemoContainer
onready var name_label := $Panel/MarginContainer/VBoxContainer/Label

var demo_screen: DemoScreen setget _set_demo_screen

func _ready():
	self.demo_screen = demo_loader.get_first_screen().instance()


func _input(event):
	if event.is_action_pressed("next_demo"):
		on_next()
	elif event.is_action_pressed("previous_demo"):
		on_previous()
	elif event.is_action_pressed("reset_demo"):
		pass
#		on_reset()

func _set_demo_screen(demo_screen: DemoScreen):
	demo_container.demo_screen = demo_screen
	_update_control_node(demo_screen)
	

func on_reset():
	self.demo_screen = demo_loader.get_current_screen().instance()


func on_next():
	self.demo_screen = demo_loader.next().instance()


func on_previous():
	self.demo_screen = demo_loader.back().instance()


func _update_control_node(demo_screen: DemoScreen):
	name_label.text = "Name: " + demo_screen.get_name()
