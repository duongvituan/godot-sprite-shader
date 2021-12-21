extends DemoScreen

func get_name() -> String:
	return "Outline"


func _ready():
	$CharOutline/EzShaderPlayer/EzOutline.is_active = true
	$CharOutlineEmpty/EzShaderPlayer/EzOutlineEmpty.is_active = true
