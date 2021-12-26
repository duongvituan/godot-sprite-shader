extends DemoScreen

func get_name() -> String:
	return "Matrix"

func _ready():
	$Char2/EzShaderPlayer/EzMatrix.is_active = true
