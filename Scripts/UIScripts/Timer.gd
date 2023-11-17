extends Label

signal timer_reached

@export var seconds : int

@onready var progress_bar = $ProgressBar
@onready var timer = Timer.new()

func _ready():
	progress_bar.max_value = seconds
	setup_timer()

func setup_timer():
	add_child(timer)
	timer.one_shot = false
	timer.wait_time = 1
	timer.connect("timeout", _on_timeout)
	timer.start()

func _on_timeout():
	if seconds > 0:
		seconds -= 1
	else:
		timer_reached.emit()
		timer.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	progress_bar.value = seconds
	text = str(seconds)
