extends Node2D

@onready var interact_area =  $InteractionArea

# Called when the node enters the scene tree for the first time.
func _ready():
	interact_area.interact = Callable(self, "_on_interact")

func _on_interact():
	print("made some coffee")
