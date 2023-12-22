extends Control

@onready var options_menu = $CenterContainer/Menu/OptionsMenu
var paused : bool = true #this works I dunno why
var click = load("res://Assets/SFX/click_sfx.ogg")

func _ready():
	options_menu.back.connect(_show_buttons)

func _show_buttons():
	$CenterContainer/Menu/Buttons.show()
	AudioManager.play_sound(click)

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
	AudioManager.play_sound(click)

func _on_resume_pressed():
	pause_game()
	AudioManager.play_sound(click)

func _on_options_pressed():
	$CenterContainer/Menu/Buttons.hide()
	$CenterContainer/Menu/OptionsMenu.show()
	AudioManager.play_sound(click)

func _on_yes_pressed():
	SceneChanger.change_scene("res://Nodes/UI/main_menu.tscn", "slide_left")
	AudioManager.play_sound(click)

func _on_no_pressed():
	$CenterContainer/Confirmation.hide()
	$CenterContainer/Menu.show()
	AudioManager.play_sound(click)
