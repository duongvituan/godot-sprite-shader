extends DemoScreen


func get_name() -> String:
	return "Transform"


func _ready():
	$Char2/EzTransfromGold.is_active = true
	
	$Char3/EzTransformMetal.is_active = true
	
	$Char4/EzTransformGhost.is_active = true
	
	$Char5/EzTransfromFreeze.is_active = true
	
	$Char6/EzTransfromBurn.is_active = true
