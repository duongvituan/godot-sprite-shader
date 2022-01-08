extends KinematicBody2D

onready var muzzle = $MuzzlePosition


func _ready():
	$SkillButtons/HBoxContainer/Button.connect("button_down", self, "spam_bullet_normal")
	$SkillButtons/HBoxContainer/Button2.connect("button_down", self, "spam_bullet_freeze")
	$SkillButtons/HBoxContainer/Button3.connect("button_down", self, "spam_bullet_fire")


func spam_bullet_normal():
	Utils.create_bullet_normal(muzzle.global_position, get_parent())

func spam_bullet_freeze():
	Utils.create_bullet_freeze(muzzle.global_position, get_parent())

func spam_bullet_fire():
	Utils.create_bullet_fire(muzzle.global_position, get_parent())


