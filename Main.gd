extends Node2D

onready var bullet_manager = $BulletManager
onready var player: Player = $Player
onready var health_bar = $GUI/MarginContainer/Rows/BottomRow/HealthBar

func _ready():
    if $BulletManager:
        print("BulletManager found")
        var global_bullet = GlobalSignals.connect("bullet_fired", $BulletManager, "handle_bullet_spawned")
        print("connected ", global_bullet)
    else:
        print("BulletManager not found!")
    
    if player and health_bar:
        player.connect("player_took_damage", health_bar, "_on_PlayerDamaged")
        print("Player damage signal connected")
    else:
        print("Player or health_bar not found!")