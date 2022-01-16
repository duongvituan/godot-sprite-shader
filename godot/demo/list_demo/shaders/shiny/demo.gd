extends DemoScreen


func get_name() -> String:
	return "Shiny"


func _ready():
	# Static Shiny
	$Char3/SShaderContainer/SSShinyFx.process_value = 0.5 # 0.5 mean shiny at center sprite
	$Char2/SShaderContainer/SSShinyFx.is_active = true
	
	# Animation Shiny to Left
	$Char3/SShaderContainer/SSShinyFx.direction = 0
	$Char3/SShaderContainer/SSShinyFx.play_repeat_forever(2.0)

	# Animation Shiny to Right
	$Char4/SShaderContainer/SSShinyFx.direction = 1
	$Char4/SShaderContainer/SSShinyFx.play_repeat_forever(2.0)

	# Animation Shiny Swing (move left to right and right to left)
	$Char5/SShaderContainer/SSShinyFx.direction = 2
	$Char5/SShaderContainer/SSShinyFx.play_repeat_forever(2.0)
