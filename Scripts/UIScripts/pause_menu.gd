extends Control

func _ready():
	$CenterContainer/Menu/Buttons/Resume.grab_focus()

func _on_quit_pressed():
	get_tree().quit()
