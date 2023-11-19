extends Resource

class_name GameManager
signal game_end

@export var game_minutes : int
@export var game_seconds : int

func _reset():
	game_minutes = 1
	game_seconds = 30
