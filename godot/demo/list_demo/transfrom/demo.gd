extends DemoScreen


func get_name() -> String:
	return "Transform"


func _ready():
	$Char2/EzShaderPlayer/EzTransfromGold.play_repeat_forever(3.0)
	
	$Char3/EzShaderPlayer/EzTransformMetal.play_repeat_forever(2.0)
	
	$Char4/EzShaderPlayer/EzTransformGhost.play_repeat_forever(6.0)
	
	$Char5/EzShaderPlayer/EzTransfromFreeze.play_repeat_forever(5.0)
	
	$Char6/EzShaderPlayer/EzTransfromBurn.play_repeat_forever(3.0)
