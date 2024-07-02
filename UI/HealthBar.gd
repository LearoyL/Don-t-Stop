extends ProgressBar


export var max_health = 100  # Maximum health value
var current_health = max_health  # Initial health value

signal player_died  # Signal emitted when the player dies

func _ready():
	# Set the maximum value of the health bar
	max_value = max_health
	# Set the current value of the health bar
	value = current_health

func _on_PlayerDamaged(new_health: int):
	value = new_health
	print ("updated , this is new health ", new_health)
	# Emit the health_changed signal with the current health value
	# Check if the current health is less than or equal to 0
	if new_health <= 0:
		# Emit the player_died signal
		emit_signal("player_died")
		# Reset the current health to 0
		current_health = 0
		# Update the health bar value
		value = current_health
		# Emit the health_changed signal with the current health value