extends DemoScreen

var is_active = false

func get_name() -> String:
	return "Dissolve"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("active"):
		start_to_dust()


func start_to_dust():
	if not is_active:
		is_active = true
		
		# If you use this shader for Sprite ỏor RectTexure then offset_y value can be -0.85
		# If you use this shader for Viewport then offset_y value can be -0.85
		$Char2/EzDissolveDust.offset_y = -0.15
		$Char2/EzDissolveDust.play(1.0, false)

		$Char2.stop_sprite_animation()
