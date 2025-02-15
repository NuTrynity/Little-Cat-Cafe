extends Control

func _ready() -> void:
	$"%PlayBtn".grab_focus()

func _on_play_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/TestScene.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
