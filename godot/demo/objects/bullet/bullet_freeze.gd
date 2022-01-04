extends Area2D

var BULLET_SPEED = 300.0
var damage = 1

func _ready():
	connect("body_entered", self, "_on_Hitbox_body_entered")
	damage = Utils.random(50, 100)

func _physics_process(delta):
	position.x += BULLET_SPEED * delta
	

func _on_Hitbox_body_entered(body):
	if body is Dino:
		body.hit_freeze_bullet(damage)
		queue_free()
