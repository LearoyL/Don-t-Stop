extends Node2D

export var max_health: int = 100
var health: int = max_health setget set_health

func set_health(value: int):
    health = clamp(value, 0, max_health)