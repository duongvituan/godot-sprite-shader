extends DemoScreen

onready var megaman := $MegaMan

func get_name() -> String:
	return "Game (Dummy version)"


func _input(event):
	if event.is_action_released("active"):
		magaman_spawm_bullet()

func magaman_spawm_bullet():
	megaman.fire()
