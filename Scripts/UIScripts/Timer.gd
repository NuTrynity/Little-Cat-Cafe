extends Label

@export var game_manager : GameManager

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
	if game_manager.game_minutes || game_manager.game_seconds != 0:
		if game_manager.game_minutes >= 0:
			game_manager.game_seconds -= 1
			if game_manager.game_seconds < 0:
				game_manager.game_minutes -= 1
				game_manager.game_seconds = 60
	else:
		game_manager.game_end.emit()
		timer.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if game_manager.game_minutes < 10:
		text = "0" + str(game_manager.game_minutes) + ":" + str(game_manager.game_seconds)
		if game_manager.game_seconds < 10:
			text = "0" + str(game_manager.game_minutes) + ":" + "0" + str(game_manager.game_seconds)
