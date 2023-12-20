extends Control

@onready var main_menu_bg = preload("res://Assets/Music/Main Menu.wav")
@onready var main_menu_stream = $MainMenuMusic
@onready var options_menu = $CenterContainer/OptionsMenu
@onready var save_loader = $SaveLoader

var click = load("res://Assets/SFX/click_sfx.ogg")

func _ready():
	get_tree().paused = false
	$CenterContainer/Buttons/Play.grab_focus()
	options_menu.back.connect(_show_menu)
	main_menu_stream.play()

func _show_menu():
	$CenterContainer/Buttons.show()

func _on_play_pressed():
	SceneChanger.change_scene("res://scene_0.tscn", "slide_left")
	AudioManager.play_sound(click)

func _on_options_pressed():
	$CenterContainer/Buttons.hide()
	$CenterContainer/OptionsMenu.show()
	AudioManager.play_sound(click)

func _on_quit_pressed():
	$CenterContainer/Confirmation/Container/Buttons/No.grab_focus()
	$CenterContainer/Buttons.hide()
	$CenterContainer/Confirmation.show()
	AudioManager.play_sound(click)

func _on_yes_pressed():
	get_tree().quit()
	AudioManager.play_sound(click)

func _on_no_pressed():
	$CenterContainer/Buttons/Play.grab_focus()
	$CenterContainer/Buttons.show()
	$CenterContainer/Confirmation.hide()
	AudioManager.play_sound(click)

func _on_continue_pressed():
	'''
	TODO: Code something that checks if the game has the save file
	then go to the game, also make the continue button appear when
	there is a save
	'''
	save_loader.load_game()
	SceneChanger.change_scene("res://scene_0.tscn", "slide_left")
	AudioManager.play_sound(click)
