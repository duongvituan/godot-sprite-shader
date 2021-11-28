extends Sprite

export var title: String = "Normal" setget _set_title


func _set_title(value):
	$Label.text = value

