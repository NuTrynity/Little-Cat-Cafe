extends CanvasLayer

var is_paused : bool = false

func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):
		pause_game()

func pause_game():
	is_paused = !is_paused
	
	if is_paused:
		$"%Resume".grab_focus()
		show()
		get_tree().paused = true
	else:
		hide()
		get_tree().paused = false

func _on_resume_pressed() -> void:
	pause_game()

func _on_options_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	get_tree().paused = false
	SceneLoader.transition_to("res://Scenes/MainMenu.tscn", "circle_transition")
