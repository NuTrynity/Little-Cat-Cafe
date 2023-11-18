extends Node2D

@export var player_resources : PlayerMealCarry

@onready var placement_pts = $PlacementPoints

var take_meal_sfx = load("res://Assets/SFX/meal_place_edit.mp3")

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
			print(item_count())
			AudioManager.play_sound(take_meal_sfx)
			
			return
	print("tray is full")
		
func _give_meal(npc):
	for point in placement_pts.get_children():
		if !point.get_is_empty():
			if check_meal_match(point, npc):
				var meal = point.remove_item()
				npc.grab_meal(meal)
				AudioManager.play_sound(take_meal_sfx)
				# check if there are no meals left
				print(item_count())
				if item_count() <= 0:
					visible = false
				return
	print("no meals or wrong meals")
	
func item_count() -> int:
	var count = 0
	for point in placement_pts.get_children():
		if !point.get_is_empty():
			count += 1
	return count
	
func check_meal_match(point, npc : Node2D = null) -> bool:
	if (npc.meal_i_want == null):
		return true
	
	if npc.meal_i_want == point.held_item.meal_index:
		return true
	else:
		return false
