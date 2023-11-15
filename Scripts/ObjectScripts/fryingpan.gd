extends Node2D

@onready var interact_area = $InteractionArea

var meal = preload("res://Nodes/Templates/meal_template.tscn")

func _ready():
	interact_area.interact = Callable(self, "_on_interaction")

func _on_interaction():
	var placement_pts = get_tree().get_root().get_node("scene_0/KitchenCounter2/PickupTablecloth/PlacementPoints")
	var pickup_full = true
	for point in placement_pts.get_children():
		if point.get_is_empty():
			var food = meal.instantiate()
			add_child(food)
			point.add_item(food)
			pickup_full = false
			break
	if pickup_full:
		print("can't cook, pickup is full")

