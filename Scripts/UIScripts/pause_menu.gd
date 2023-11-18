extends Control

@onready var options_menu = $CenterContainer/Menu/OptionsMenu
var paused : bool = true #this works I dunno why

func _ready():
	options_menu.back.connect(_show_buttons)

func _show_buttons():
	$CenterContainer/Menu/Buttons.show()

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
	$CenterContainer/Confirmation.show()
	$CenterContainer/Menu.hide()

func _on_resume_pressed():
	pause_game()

func _on_options_pressed():
	$CenterContainer/Menu/Buttons.hide()
	$CenterContainer/Menu/OptionsMenu.show()

func _on_yes_pressed():
	get_tree().change_scene_to_file("res://Nodes/UI/main_menu.tscn")
	get_tree().paused = false

func _on_no_pressed():
	$CenterContainer/Confirmation.hide()
	$CenterContainer/Menu.show()
