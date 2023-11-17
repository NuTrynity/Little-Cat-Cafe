extends Control

@onready var main_menu_bg = preload("res://Assets/Music/Main Menu.wav")
@onready var main_menu_stream = $MainMenuMusic

func _ready():
	$CenterContainer/Buttons/Play.grab_focus()
	main_menu_stream.play()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scene_0.tscn")

func _on_how_to_play_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()
