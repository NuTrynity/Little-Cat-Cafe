extends Resource

class_name GameManager
signal game_end

@export var game_minutes : int
@export var game_seconds : int

var current_minutes : int
var current_seconds : int

func set_default():
	current_minutes = game_minutes
	current_seconds = game_seconds

func _reset():
	game_minutes = current_minutes
	game_seconds = current_seconds
