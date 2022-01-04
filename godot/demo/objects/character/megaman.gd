extends KinematicBody2D

enum BULLET {Normal, Freeze, Fire}

onready var muzzle = $MuzzlePosition
onready var option_button = $Bullet/OptionButton

var current_bullet = BULLET.Normal


func _ready():
	set_process(false)
	option_button.connect("item_selected", self, "on_bullet_button_selected")

func on_bullet_button_selected(value):
	current_bullet = value

func fire():
	match current_bullet:
		BULLET.Normal:
			Utils.create_bullet_normal(muzzle.global_position, get_parent())
		BULLET.Freeze:
			Utils.create_bullet_freeze(muzzle.global_position, get_parent())
		BULLET.Fire:
			Utils.create_bullet_fire(muzzle.global_position, get_parent())

