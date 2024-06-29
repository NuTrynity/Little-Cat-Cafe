extends Resource

class_name GameManager
signal game_end
signal day_end
signal game_finished
signal start_combo

@export var game_minutes : int
@export var game_seconds : int

var current_minutes : int
var current_seconds : int
var combo_meter : int = 1
var tutorial_npc : bool = true

# check day end is in the NPC code for now
func check_result():
	'''
	customers -= 1
	if customers <= 0:
		day_end.emit()
	'''
	pass

func check_timer_done() -> bool:
	return current_minutes <= 0 and current_seconds <= 0

func end_day():
	day_end.emit()

func set_timer():
	current_minutes = game_minutes
	current_seconds = game_seconds
