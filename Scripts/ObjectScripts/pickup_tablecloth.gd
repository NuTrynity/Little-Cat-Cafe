extends Node2D

@export var player_resources : PlayerMealCarry

@onready var interact_area = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("player")
@onready var placement_pts = $PlacementPoints

func _ready():
	interact_area.interact = Callable(self, "_on_pick_up")
	#player_resources.meal_given.connect(give_meal)

func _on_pick_up():
	if (pickup_is_empty()):
		print("nothing to pickup")
	elif player_resources.carry_amt >= player_resources.max_amt:
		print("tray is full")
	else:
		player_resources.take_meal(pickup_meal())

func pickup_is_empty():
	for point in placement_pts.get_children():
		if !point.get_is_empty():
			return false
	return true
	
func pickup_meal() -> Node2D:
	for point in placement_pts.get_children():
		if !point.get_is_empty():
			return point.remove_item()
	("null")
	return null
	
