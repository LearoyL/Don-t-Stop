extends KinematicBody2D

signal died

onready var health_stat = $Health
onready var ai = $AI
onready var weapon = $Weapon

func _ready():
	ai.initialize(self, weapon)

func take_damage():
	health_stat.health -= 20
	if health_stat.health <= 0:
		queue_free()
		print("Enemy died")
		_on_die()

func _on_die():
	emit_signal("died")  # Emit the died signal when the enemy dies
	queue_free()  # Remove the enemy instance from the scene