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
		
		# Dissolve to Dust
		# If you use this shader for Sprite ỏor RectTexure then offset_y value can be -0.85
		# If you use this shader for Viewport then offset_y value can be -0.85
		$Char2/EzDissolveDust.offset_y = -0.15
		$Char2/EzDissolveDust.play(1.0, false)
		$Char2.stop_sprite_animation()
		
		
		# Dissolve with fire
		$Char3/EzDissolveBurn.play(1.0, false)
		$Char3.stop_sprite_animation()
		
		
		# Dissolve with circle
		$Char4/EzDissolveCircle.play(1.0, false)
		$Char4.stop_sprite_animation()
	else:
		is_active = false
		$Char2/EzDissolveDust.offset_y = -0.15
		$Char2/EzDissolveDust.play_reverse(1.0, false)
		$Char2.play_sprite_animation()
		
		$Char3/EzDissolveBurn.play_reverse(1.0, false)
		$Char3.play_sprite_animation()
		
		$Char4/EzDissolveCircle.play_reverse(1.0, false)
		$Char4.play_sprite_animation()
