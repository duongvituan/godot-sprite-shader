extends Node2D

var text := "999"
var color := Color.lightgoldenrod setget _set_color
var rng = RandomNumberGenerator.new()

var _max_scale = Vector2.ONE
var _max_move_up = 50.0

func start(type: int):
	match type:
		0:
			self.color = Color.white
			_max_scale *= 0.9
		1:
			self.color = Color.aqua
			_max_scale *= 1
			_max_move_up = 75
		2:
			self.color = Color.orange
			_max_scale *= 1.2
			_max_move_up = 75
	$Label.text = text
	_animated()


func _animated():
	rng.randomize()
	position = Vector2(rng.randf_range(position.x - 15, position.x + 15), rng.randf_range(position.y - 15, position.y + 15))
	$Tween.interpolate_property($Label, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.interpolate_property(self, "scale", Vector2.ZERO, _max_scale, 0.2, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.interpolate_property(self, "rotation_degrees", 0, rng.randf_range(-15, 15), 0.3, Tween.TRANS_CIRC, Tween.EASE_OUT)
	$Tween.interpolate_property(self, "position", position, Vector2(position.x, position.y-_max_move_up), 0.5, Tween.TRANS_CIRC, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	queue_free()


func _set_color(value):
	$Label.set("custom_colors/font_color", value)
