extends DemoScreen

func get_name() -> String:
	return "Outline"


func _ready():
	$CharOutline/SShaderContainer/SSOutline.is_active = true
	$CharOutlineEmpty/SShaderContainer/SSOutlineEmpty.is_active = true
