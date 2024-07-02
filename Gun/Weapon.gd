extends Node2D
class_name Weapon

export(PackedScene) var Bullet

signal weapon_no_ammo()

onready var max_ammo: int = 5
onready var current_ammo: int = max_ammo

onready var end_of_gun = $EndOfGun
onready var gun_direction = $GunDirection
onready var attack_cooldown = $AttackCooldown
onready var animation_player = $AnimationPlayer

func shoot():
		if current_ammo!=0 and attack_cooldown.is_stopped() and Bullet != null:
			var bullet_instance = Bullet.instance()
			var direction = gun_direction.global_position - end_of_gun.global_position
			# print("shoot")
			print("Emitting bullet_fired signal")
			GlobalSignals.emit_signal("bullet_fired", bullet_instance, end_of_gun.global_position, direction.normalized())
			attack_cooldown.start()
			animation_player.play("muzzle_flash")
			current_ammo -= 1
			print("Current ammo: ", current_ammo)
			if current_ammo <= 0:
				emit_signal("weapon_no_ammo")
				# print("Out of ammo")

func start_reload():
	animation_player.play("reload")
func _stop_reload():
	current_ammo = max_ammo
	print("Reload stopped")