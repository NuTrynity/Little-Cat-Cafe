extends Resource

class_name GameManager
signal game_end
signal day_end
signal game_finished
signal start_combo

@export var game_minutes : int
@export var game_seconds : int

var customers : int = 0
var current_minutes : int
var current_seconds : int
var combo_meter : int = 1
var tutorial_npc : bool = true

func check_result():
	if customers <= 0:
		day_end.emit()

func set_default():
	current_minutes = game_minutes
	current_seconds = game_seconds

func _reset():
	game_minutes = current_minutes
	game_seconds = current_seconds
