extends DemoScreen


func get_name() -> String:
	return "Transform"


func _ready():
	$Char2/EzTransfromGold.play_repeat_forever(3.0)
	
	$Char3/EzTransformMetal.play_repeat_forever(2.0)
	
	$Char4/EzTransformGhost.play_repeat_forever(6.0)
	
	$Char5/EzTransfromFreeze.play_repeat_forever(5.0)
	
	$Char6/EzTransfromBurn.play_repeat_forever(3.0)
