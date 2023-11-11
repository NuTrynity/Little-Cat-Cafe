extends Node2D

@onready var interaction_area = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_on_pick_up")

func _on_pick_up():
	print('Meal Picked Up! Congratulations for making a very complex code just for this!')
