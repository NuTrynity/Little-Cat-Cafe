extends Resource

class_name GameManager
signal game_end
signal day_end
signal game_finished

@export var game_minutes : int
@export var game_seconds : int

var customers : int = 0
var current_minutes : int
var current_seconds : int

var sfx_volume : float = 1
var music_volume : float = 1

func check_result():
	customers -= 1
	
	if customers <= 0:
		day_end.emit()

func set_default():
	current_minutes = game_minutes
	current_seconds = game_seconds

func _reset():
	game_minutes = current_minutes
	game_seconds = current_seconds
