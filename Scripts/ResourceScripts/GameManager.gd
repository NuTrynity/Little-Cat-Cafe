extends Resource

class_name GameManager
signal game_end

@export var game_minutes : int
@export var game_seconds : int

var days : int = 1
var current_minutes : int
var current_seconds : int

var sfx_volume : float = 1
var music_volume : float = 1

func set_default():
	current_minutes = game_minutes
	current_seconds = game_seconds

func _reset():
	game_minutes = current_minutes
	game_seconds = current_seconds
