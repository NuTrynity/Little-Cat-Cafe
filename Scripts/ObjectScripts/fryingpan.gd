extends Node2D

@onready var interact_area = $InteractionArea

var omurice = preload("res://Nodes/Meals/omurice.tscn")
var cooking_sfx = load("res://Assets/SFX/pan-_frying.mp3")

func _ready():
	interact_area.interact = Callable(self, "_on_interaction")

func _on_interaction():
	var tablecloth = get_tree().get_root().get_node("scene_0/KitchenCounter2/PickupTablecloth")
	var placement_pts = tablecloth.get_node("PlacementPoints")
	
	var pickup_full = true
	for point in placement_pts.get_children():
		if point.get_is_empty():
			var food = omurice.instantiate()
			tablecloth.add_child(food)
			point.add_item(food)
			GlobalScript.inventory[0]["count"] += 1
			pickup_full = false
			AudioManager.play_sound(cooking_sfx)
			break
	if pickup_full:
		print("can't cook, pickup is full")
