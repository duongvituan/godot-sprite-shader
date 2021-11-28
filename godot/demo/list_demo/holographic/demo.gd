extends DemoScreen

func get_name() -> String:
	return "Holographic"

func _ready():
	$Char2/EzHolographic.is_active = true
