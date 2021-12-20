extends DemoScreen

func get_name() -> String:
	return "PingPong"


func _ready():
	$Char2/EzShaderPlayer/EzPingPongMove.play_repeat_forever(1.0)
	$Char3/EzShaderPlayer/EzPingPongRotate.play_repeat_forever(1.0)
	$Char4/EzShaderPlayer/EzPingPongZoom.play_repeat_forever(1.0)
