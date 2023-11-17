extends Node2D

@onready var interact_area =  $InteractionArea
var meal = preload("res://Nodes/Meals/cat_latte.tscn")

func _ready():
	interact_area.interact = Callable(self, "_on_interact")

func _on_interact():
	var tablecloth = get_tree().get_root().get_node("scene_0/KitchenCounter2/PickupTablecloth")
	var placement_pts = tablecloth.get_node("PlacementPoints")
	
	var pickup_full = true
	for point in placement_pts.get_children():
		if point.get_is_empty():
			var food = meal.instantiate()
			tablecloth.add_child(food)
			point.add_item(food)
			GlobalScript.inventory[1]["count"] += 1
			pickup_full = false
			break
	if pickup_full:
		print("can't cook, pickup is full")
