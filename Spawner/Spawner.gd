extends Node2D

export (PackedScene) var enemy_scene
export (NodePath) var spawn_point_path

signal enemy_died

onready var optional_spawn_point = get_node_or_null(spawn_point_path)
var spawn_points = []

func get_spawn_points():
	var points = []
	if $SpawnPoint1 != null:
		points.append($SpawnPoint1)
	if $SpawnPoint2 != null:
		points.append($SpawnPoint2)
	if $SpawnPoint3 != null:
		points.append($SpawnPoint3)
	if $SpawnPoint4 != null:
		points.append($SpawnPoint4)
	if $SpawnPoint5 != null:
		points.append($SpawnPoint5)
	if optional_spawn_point != null:
		points.append(optional_spawn_point)
	return points

func _ready():
	spawn_points = get_spawn_points()
	spawn_enemy()
	connect("enemy_died", self, "start_respawn_timer")

func spawn_enemy():
	if enemy_scene == null:
		print("Enemy scene is null.")
		return
	if spawn_points.size() > 0:
		var enemy_instance = enemy_scene.instance()
		var spawn_index = randi() % spawn_points.size()
		var spawn_point = spawn_points[spawn_index]
		if spawn_point != null:
			print("Spawning enemy at spawn point:", spawn_point.name)
			enemy_instance.position = spawn_point.position
			add_child(enemy_instance)
			enemy_instance.connect("died", self, "_on_enemy_died")
		else:
			print("Selected spawn point is null.")
	else:
		print("No spawn points available.")

func start_respawn_timer(duration):
	var respawn_timer = Timer.new()
	duration = 1
	respawn_timer.wait_time = duration
	respawn_timer.one_shot = true  # This ensures the timer only runs once
	add_child(respawn_timer)
	respawn_timer.connect("timeout", self, "_on_respawn_timer_timeout")
	respawn_timer.start()

func _on_respawn_timer_timeout():
	respawn_enemy()
	
func respawn_enemy():
	spawn_enemy()

func _on_enemy_died():
	emit_signal("enemy_died", 1)
