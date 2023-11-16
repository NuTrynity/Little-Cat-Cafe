extends Node2D

@export var player_resources : PlayerMealCarry

@onready var placement_pts = $PlacementPoints

# Called when the node enters the scene tree for the first time.
func _ready():
	player_resources.meal_taken.connect(_take_meal)
	player_resources.meal_given.connect(_give_meal)
	
func _take_meal(meal):
	for point in placement_pts.get_children():
		if point.get_is_empty():
			meal.get_parent().remove_child(meal)
			self.add_child(meal)
			point.add_item(meal)
			return
	print("tray is full")
		
func _give_meal(npc):
	for point in placement_pts.get_children():
		if !point.get_is_empty():
			var meal = point.remove_item()
			npc.grab_meal(meal)
			return
	print("no meals or wrong meals")
