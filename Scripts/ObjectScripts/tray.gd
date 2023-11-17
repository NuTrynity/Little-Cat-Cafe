extends Node2D

@export var player_resources : PlayerMealCarry

@onready var placement_pts = $PlacementPoints

var take_meal_sfx = load("res://Assets/SFX/meal_place.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	player_resources.meal_taken.connect(_take_meal)
	player_resources.meal_given.connect(_give_meal)
	
func _take_meal(meal):
	visible = true
	for point in placement_pts.get_children():
		if point.get_is_empty():
			meal.get_parent().remove_child(meal)
			self.add_child(meal)
			point.add_item(meal)
			AudioManager.play_sound(take_meal_sfx)
			return
	print("tray is full")
		
func _give_meal(npc):
	for point in placement_pts.get_children():
		while !point.get_is_empty():
			var meal = point.remove_item()
			npc.grab_meal(meal)
			AudioManager.play_sound(take_meal_sfx)
			# check if there are no meals left
			for i in GlobalScript.inventory:
				if GlobalScript.inventory[i]["count"] <= 0:
					visible = false
			
			return
	print("no meals or wrong meals")
