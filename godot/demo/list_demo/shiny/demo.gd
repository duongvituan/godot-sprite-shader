extends DemoScreen


func get_name() -> String:
	return "Shiny"


func _ready():
	# Static Shiny
	$Char3/EzShinyFx.process_value = 0.5 # 0.5 mean shiny at center sprite
	$Char2/EzShinyFx.is_active = true
	
	# Animation Shiny to Left
	$Char3/EzShinyFx.direction = 0
	$Char3/EzShinyFx.play_repeat_forever(2.0)

	# Animation Shiny to Right
	$Char4/EzShinyFx.direction = 1
	$Char4/EzShinyFx.play_repeat_forever(2.0)

	# Animation Shiny Swing (move left to right and right to left)
	$Char5/EzShinyFx.direction = 2
	$Char5/EzShinyFx.play_repeat_forever(2.0)
