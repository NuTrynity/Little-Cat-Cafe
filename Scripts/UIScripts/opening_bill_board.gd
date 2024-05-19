extends CanvasLayer

func goto_menu():
	SceneManager.change_scene(
		"res://Nodes/UI/main_menu.tscn",
		{"pattern":"radial"}
	)
