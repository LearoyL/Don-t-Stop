extends Node2D

onready var bullet_manger = $BulletManager
onready var player: Player = $Player

func _ready() -> void:
	GlobalSignals.connect("bullet_fired", bullet_manger, "handle_bullet_spawned")
