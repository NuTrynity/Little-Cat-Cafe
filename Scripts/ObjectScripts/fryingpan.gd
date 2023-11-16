extends Node2D

@onready var interact_area = $InteractionArea
@onready var meal_menu = $CookMenu

var omurice = preload("res://Nodes/Meals/omurice.tscn")

func _ready():
	interact_area.interact = Callable(self, "_on_interaction")
	meal_menu.cook_omurice.connect(spawn_meal)

func _on_interaction():
	meal_menu.show()

func spawn_meal():
	var tablecloth = get_tree().get_root().get_node("scene_0/KitchenCounter2/PickupTablecloth")
	var placement_pts = tablecloth.get_node("PlacementPoints")
	
	var pickup_full = true
	for point in placement_pts.get_children():
		if point.get_is_empty():
			var food = omurice.instantiate()
			tablecloth.add_child(food)
			point.add_item(food)
			pickup_full = false
			meal_menu.hide()
			break
	if pickup_full:
		print("can't cook, pickup is full")
