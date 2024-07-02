extends Node2D

onready var bullet_manger = $BulletManager
onready var player: Player = $Player
onready var health_bar = $GUI/MarginContainer/Rows/BottomRow/HealthBar

func _ready() -> void:
	GlobalSignals.connect("bullet_fired", bullet_manger, "handle_bullet_spawned")
	player.connect("player_took_damage", health_bar, "_on_PlayerDamaged")