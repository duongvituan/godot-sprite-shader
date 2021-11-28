extends DemoScreen

func get_name() -> String:
	return "Outline"


func _ready():
	$CharOutline/EzOutline.is_active = true
	$CharOutlineEmpty/EzOutlineEmpty.is_active = true
