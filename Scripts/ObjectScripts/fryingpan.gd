extends Node2D

@onready var interact_area

var meal = preload("res://Nodes/Templates/meal_template.tscn")

func _ready():
	interact_area.interact = Callable(self, "_on_interaction") #TODO LOOKS FOR WHY THIS IS BROKEN

func _on_interaction():
	var food = meal.instantiate()
	food.positionx += 36
	add_child(food)
