extends KinematicBody2D
class_name Player


export(int) var SPEED = 300

onready var health_stat = $Health
onready var weapon = $Weapon


func _physics_process(_delta): # Process the player movement
	var movement_direction := Vector2()

	if Input.is_action_pressed("right"):
		movement_direction.x += 1
	if Input.is_action_pressed("left"):
		movement_direction.x -= 1
	if Input.is_action_pressed("down"):
		movement_direction.y += 1
	if Input.is_action_pressed("up"):
		movement_direction.y -= 1
	movement_direction = movement_direction.normalized()
	var _collision_vector = move_and_slide(movement_direction * SPEED) # Move the player
	# print(collision_vector)

	look_at(get_global_mouse_position()) # Look at the mouse position

func _unhandled_input(event): # Handle the player input of shooting
	if event.is_action_pressed("shoot"):
		weapon.shoot()

func take_damage():
	health_stat.health -= 20
	print("Player took damage, ", health_stat.health)
