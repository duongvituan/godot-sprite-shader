extends Node

var DamageLabel = preload("res://demo/objects/damage_label.tscn")

const ButlletNormal = preload("res://demo/objects/bullet/bullet_normal.tscn")
const ButtletFreeze = preload("res://demo/objects/bullet/bullet_freeze.tscn")
const ButtletFire = preload("res://demo/objects/bullet/bullet_fire.tscn")

func random(from: int, to: int):
	if from >= to:
		return to
	return randi() % (to - from) + from

func randomf(from: float, to: float):
	if from >= to:
		return to
	return randf() * (to - from) + from

func instance_scene(scene, position, parrent = null):
	if parrent == null:
		parrent = get_tree().current_scene
	var instance = scene.instance()
	parrent.add_child(instance)
	instance.global_position = position
	return instance


func create_damage_label(text, position, type = 0):
	var damage_label = instance_scene(DamageLabel, position)
	damage_label.text = text
	damage_label.start(type)

func create_bullet_normal(position, parrent = null):
	return instance_scene(ButlletNormal, position, parrent)

func create_bullet_freeze(position, parrent = null):
	return instance_scene(ButtletFreeze, position, parrent)

func create_bullet_fire(position, parrent = null):
	return instance_scene(ButtletFire, position, parrent)
