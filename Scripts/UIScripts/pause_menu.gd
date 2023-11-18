extends Control

var paused : bool = true #this works I dunno why

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause_game()

func pause_game():
	if paused == true:
		$CenterContainer/Menu/Buttons/Resume.grab_focus()
		show()
		get_tree().paused = true
	else:
		hide()
		get_tree().paused = false
	
	paused = !paused

func _on_quit_pressed():
	get_tree().quit()

func _on_resume_pressed():
	pause_game()
