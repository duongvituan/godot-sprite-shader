extends DemoScreen

func get_name() -> String:
	return "Matrix"

func _ready():
	$Char2/EzShaderPlayer/EzMatrix.is_active = true
	$Char3/EzShaderPlayer/EzMatrixGradient.is_active = true
	$Char4/EzShaderPlayer/EzMatrixOneColor.is_active = true
