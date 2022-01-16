# temporary view make noise and save to png
# In color rect create shader and code noise
# Run this scene and press space to save noise to png

extends Control

onready var view = $ViewportContainer/Viewport

func _input(event):
	if event.is_action_pressed("active"):
		_save_noise()

func _save_noise():
	print("save noise")
	var img = view.get_texture().get_data()
	img.save_png("noise.png")
