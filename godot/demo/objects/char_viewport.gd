extends Node2D

export var title: String = "Normal" setget _set_title


func _set_title(value):
	$Label.text = value


func stop_sprite_animation():
	$ViewportContainer/Viewport/Char/AnimationPlayer.stop(true)
