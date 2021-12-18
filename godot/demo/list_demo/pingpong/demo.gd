extends DemoScreen

func get_name() -> String:
	return "PingPong"


func _ready():
	$Char2/EzPingPongMove.play_repeat_forever(1.0)
	$Char3/EzPingPongRotate.play_repeat_forever(1.0)
	$Char4/EzPingPongZoom.play_repeat_forever(1.0)
