extends Control
@onready var main_menu_bg = preload("res://Assets/Music/Main Menu.wav")
@onready var main_menu_stream = $MainMenuMusic
@onready var options_menu = $CenterContainer/OptionsMenu
@onready var save_loader = $SaveLoader
@onready var continue_btn = $CenterContainer/Buttons/Continue

var click = load("res://Assets/SFX/click_sfx.ogg")

func _ready():
	if FileAccess.file_exists("user://savedata.tres"):
		continue_btn.disabled = false
	else:
		continue_btn.disabled = true
	
	get_tree().paused = false
	$CenterContainer/Buttons/Play.grab_focus()
	options_menu.back.connect(_show_menu)
	main_menu_stream.play()
	
	# incase we forgot to hide some menus
	$CenterContainer/Buttons.show()
	$CenterContainer/Confirmation.hide()
	$CenterContainer/NewGame.hide()
	$CenterContainer/OptionsMenu.hide()
	$CenterContainer/Credits.hide()

func _show_menu():
	$CenterContainer/Buttons.show()

func _on_play_pressed():
	if FileAccess.file_exists("user://savedata.tres"):
		$CenterContainer/NewGame.show()
		$CenterContainer/Buttons.hide()
	else:
		SceneChanger.change_scene("res://scene_0.tscn", "fade_out")
	
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
	SceneChanger.animations.play("exit")
	AudioManager.play_sound(click)
	
	await SceneChanger.animations.animation_finished
	get_tree().quit()

func _on_no_pressed():
	$CenterContainer/Buttons/Play.grab_focus()
	$CenterContainer/Buttons.show()
	$CenterContainer/Confirmation.hide()
	AudioManager.play_sound(click)

func _on_continue_pressed():
	save_loader.load_game()
	SceneChanger.change_scene("res://scene_0.tscn", "fade_out")
	AudioManager.play_sound(click)

func _on_new_game_pls_pressed():
	SceneChanger.change_scene("res://scene_0.tscn", "slide_left")
	AudioManager.play_sound(click)

func _on_continue_new_game_pressed():
	$CenterContainer/NewGame.hide()
	$CenterContainer/Buttons.show()
	AudioManager.play_sound(click)

func _on_credits_pressed():
	$CenterContainer/Buttons.hide()
	$CenterContainer/Credits.show()
	AudioManager.play_sound(click)

func _on_credits_back_pressed():
	$CenterContainer/Buttons.show()
	$CenterContainer/Credits.hide()
	AudioManager.play_sound(click)
