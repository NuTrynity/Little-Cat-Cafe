extends Label

signal timer_reached

@export var minutes : int
@export var seconds : int

@onready var timer = Timer.new()

func _ready():
	setup_timer()

func setup_timer():
	add_child(timer)
	timer.one_shot = false
	timer.wait_time = 1
	timer.connect("timeout", _on_timeout)
	timer.start()

func _on_timeout():
	if minutes || seconds != 0:
		if minutes >= 0:
			seconds -= 1
			if seconds < 0:
				minutes -= 1
				seconds = 60
	else:
		timer_reached.emit()
		timer.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if minutes < 10:
		text = "0" + str(minutes) + str(seconds)
		if seconds < 10:
			text = "0" + str(minutes) + ":" + "0" + str(seconds)
