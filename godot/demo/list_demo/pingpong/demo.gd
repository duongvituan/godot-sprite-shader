extends DemoScreen

func get_name() -> String:
	return "PingPong"


func _ready():
	$Char2/EzPingPongMove.is_active = true
	$Char3/EzPingPongRotate.is_active = true
	$Char4/EzPingPongZoom.is_active = true
