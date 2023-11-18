extends ProgressBar

signal progress_finish
@export var bar_max : float #formula: 0.1 * 10 is 1 second
@onready var parent = get_parent()

func _ready():
	max_value = bar_max
	global_position = parent.global_position
	global_position.y -= 164
	global_position.x -= size.x / 2

func _process(_delta):
	if value == max_value:
		progress_finish.emit()
		value = 0
		hide()
