extends Label
@export var game_manager : GameManager

@onready var timer = Timer.new()

func _ready():
	setup_timer()
	game_manager.set_timer()

func setup_timer():
	add_child(timer)
	timer.one_shot = false
	timer.wait_time = 1
	timer.connect("timeout", _on_timeout)
	timer.start()
	
	display_time()

func _on_timeout():
	if game_manager.current_minutes || game_manager.current_seconds != 0:
		if game_manager.current_minutes >= 0:
			game_manager.current_seconds -= 1
			if game_manager.current_seconds < 0:
				game_manager.current_minutes -= 1
				game_manager.current_seconds = 60
	else:
		game_manager.game_end.emit()
		timer.stop()
		
	display_time()
		
func display_time():
	text = str(game_manager.current_minutes) + ":" + str(game_manager.current_seconds)
	if game_manager.current_seconds < 10:
		text = str(game_manager.current_minutes) + ":" + "0" + str(game_manager.current_seconds)
		
func set_to_zero():
	game_manager.current_minutes = 0
	game_manager.current_seconds = 0
