extends Node2D

export(int) var health = 100 setget health_stat

func health_stat(new_health: int):
	health = clamp(new_health, 0, 100) # Clamp the health between 0 and 100
