extends Node2D

@export var player_resources : PlayerResource

@onready var interact_area = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
@onready var tray := player.get_node("PlayerSkin").get_node("Tray") as Node2D
@onready var placement_pts = $PlacementPoints

func _ready():
	interact_area.interact = Callable(self, "_on_pick_up")

func _on_pick_up():
	if (pickup_is_empty()):
		print("nothing to pickup")
	elif tray.item_count() >= player_resources.max_meal_amt:
		print("tray is full")
	else:
		player_resources.take_meal(pickup_meal())
		#I need to append meal_index so that the NPC can compare if they have the meal they want

func test_print():
	print("Points:")
	for point in placement_pts.get_children():
		print(point.held_item)

func pickup_is_empty():
	for point in placement_pts.get_children():
		if !point.get_is_empty():
			return false
	return true

func pickup_meal() -> Node2D:
	var point_list = []
	for point in placement_pts.get_children():
		if !point.get_is_empty():
			point_list.append(point)
	var closest_point = point_list[0]
	var min_dist = 9999
	for point in point_list:
		var dist = abs(player.global_position.x - point.global_position.x)
		if dist < min_dist:
			closest_point = point
			min_dist = dist
	return closest_point.remove_item()
