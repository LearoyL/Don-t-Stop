extends Node2D

signal state_changed(new_state)

enum State {
	FIND,
	ENGAGE
}

onready var player_detection_zone = $PlayerDetectionZone
onready var move_speed = 150

var current_state: int = State.FIND setget set_state
var actor = null
var player: Player = null
var weapon: Weapon = null

func initialize(new_actor, new_weapon: Weapon):
	self.actor = new_actor
	self.weapon = new_weapon
	weapon.connect("weapon_no_ammo", self, "handle_reload")

func _ready():
	pass
func _process(_delta):
	# print("Current state: ", current_state)
	match current_state:
		State.FIND:
			if player != null:
				actor.move_and_slide(actor.global_position.direction_to(player.global_position) * move_speed)
				actor.rotation = actor.global_position.direction_to(player.global_position).angle()
		State.ENGAGE:
			if player != null and weapon != null:
				actor.rotation = actor.global_position.direction_to(player.global_position).angle()
				weapon.shoot()
			else:
				print("Error: ENGAGE: Player or weapon not found")
		_:
			print("Error: Invalid state")


func set_state(new_state: int):
	if new_state == current_state:
		return

	current_state = new_state
	emit_signal("state_changed", current_state)


func _on_PlayerDetectionZone_body_entered(body: Node):
	if body.is_in_group("player"):
		print("Player detected")
		# print(current_state)
		set_state(State.ENGAGE)
		# print(current_state)
		player = body


func _on_PlayerDetectionZoneLeave_body_exited(body:Node):
	if body.is_in_group("player"):
		print("Player Left")
		# print(current_state)
		set_state(State.FIND)
		# print(current_state)
		player = body

func handle_reload():
	weapon.start_reload()
