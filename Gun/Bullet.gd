extends Area2D

class_name Bullet

export(int) var SPEED = 50

var direction := Vector2.ZERO

onready var kill_timer = $KillTimer

func _ready():
	kill_timer.start()

func _physics_process(_delta):
	if direction != Vector2.ZERO:
		var velocity = direction * SPEED
		
		global_position += velocity

func set_direction(new_direction: Vector2):
	self.direction = new_direction
	rotation += direction.angle()

func _on_KillTimer_timeout():
	queue_free()

func _on_Bullet_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage()
		queue_free()
