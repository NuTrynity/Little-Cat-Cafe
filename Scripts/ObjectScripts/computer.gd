extends Node2D

@onready var interact_area = $InteractionArea
@onready var computer_screen = $"../../PC"

func _ready():
	interact_area.interact = Callable(self, "_on_checked")

func _on_checked():
	computer_screen.show()
	get_tree().paused = true
