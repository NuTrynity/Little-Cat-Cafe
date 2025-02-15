extends Control

func _ready() -> void:
	$"%PlayBtn".grab_focus()

func _on_play_btn_pressed() -> void:
	SceneLoader.transition_to("res://Scenes/TestScene.tscn", "circle_transition")

func _on_quit_pressed() -> void:
	get_tree().quit()
