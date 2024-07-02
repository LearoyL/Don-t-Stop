extends KinematicBody2D
class_name Player


export(int) var SPEED = 300
export(int) var MAX_HEALTH = 100

signal player_took_damage(new_health)

onready var health_stat = $Health
onready var weapon = $Weapon

var current_health: int = MAX_HEALTH

func _ready():
	current_health = MAX_HEALTH

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
	elif event.is_action_pressed("reload"):
		weapon.start_reload()

func take_damage(amount: int = 5):
	current_health = max(0 ,current_health - amount)
	print("Player took damage: ", current_health)
	emit_signal("player_took_damage", current_health)
func reload():
	weapon.start_reload()