extends Resource
class_name PlayerStats

@export var player_speed : float

func set_speed(value : float):
	player_speed = value

func get_speed():
	return player_speed
