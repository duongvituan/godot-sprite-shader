extends KinematicBody2D
class_name Dino

enum STATUS {Normal, Freeze, Fire}

onready var one_color := $EzShaderPlayer/EzOneColor
onready var transform_freeze := $EzShaderPlayer/EzTransfromFreeze
onready var transform_burn := $EzShaderPlayer/EzTransfromBurn
onready var animation_player = $Char/ViewportContainer/Viewport/Char/AnimationPlayer

var status = STATUS.Normal
var current_burn_time = 0.0
var burn_time = 0.2


func _ready():
	transform_freeze.connect("finished", self, "_on_finised_freeze")
	transform_freeze.connect("canceled", self, "_on_canceled_freeze")
	transform_burn.connect("finished", self, "_on_finised_burn")

func _process(delta):
	if status == STATUS.Normal:
		return
	
	if status == STATUS.Fire:
		current_burn_time += delta
		if current_burn_time > burn_time:
			current_burn_time = 0
			Utils.create_damage_label(Utils.random(5, 40), global_position, 2)


func hit_normal_buttlet(damage):
	Utils.create_damage_label(String(damage), global_position, 0)
	one_color.play(0.1, true)

func hit_freeze_bullet(damage):
	Utils.create_damage_label(String(damage), global_position, 1)
	animation_player.stop()
	status = STATUS.Freeze
	transform_freeze.play(3, true)

func hit_fire_bullet(damage):
	Utils.create_damage_label(String(damage), global_position, 2)
	status = STATUS.Fire
	transform_burn.play(1, true)


func _on_finised_freeze():
	animation_player.play("Idle")
	status = STATUS.Normal

func _on_canceled_freeze():
	animation_player.play("Idle")

func _on_finised_burn():
	status = STATUS.Normal
