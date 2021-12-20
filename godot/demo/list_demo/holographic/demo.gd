extends DemoScreen

func get_name() -> String:
	return "Holographic"

func _ready():
	$Char2/EzShaderPlayer/EzHolographic.is_active = true
	
	$Char3/EzShaderPlayer/EzGlitch.play_repeat_forever(1.0)
