extends KinematicBody2D
class_name Dino

enum STATUS {Normal, Freeze, Fire}

onready var ss_container := $SShaderContainer
onready var one_color := $SShaderContainer/SSOneColor
onready var transform_freeze := $SShaderContainer/SSTransfromFreeze
onready var transform_burn := $SShaderContainer/SSTransfromBurn
onready var animation_player = $Char/ViewportContainer/Viewport/Char/AnimationPlayer

var status = STATUS.Normal

var duration_burn = 0.0
var hit_damage_burn_time = 0.2
var current_burn_time = 0.0


func _ready():
	ss_container.connect("cancel_shader", self, "_on_cancel_shader")
	ss_container.connect("finished_shader", self, "_on_finished_shader")


func _process(delta):
	if status == STATUS.Normal:
		return
	
	if status == STATUS.Fire:
		duration_burn -= delta
		
		if duration_burn < 0:
			status = STATUS.Normal
			return
		
		current_burn_time += delta
		if current_burn_time > hit_damage_burn_time:
			current_burn_time -= hit_damage_burn_time;
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
	
	var burn_effect_time = 1.0
	transform_burn.play(burn_effect_time, true)
	duration_burn = burn_effect_time


func _on_cancel_shader(ez_shader):
	if ez_shader == transform_freeze:
		animation_player.play("Idle")

func _on_finished_shader(ez_shader):
	if ez_shader == transform_freeze:
		status = STATUS.Normal
		animation_player.play("Idle")
