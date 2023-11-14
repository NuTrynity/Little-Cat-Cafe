extends Node2D

@onready var interact_area = $InteractionArea

var meal = preload("res://Nodes/Templates/meal_template.tscn")

func _ready():
	interact_area.interact = Callable(self, "_on_interaction")

func _on_interaction():
	var food = meal.instantiate()
	food.position.x += 360
	add_child(food)
