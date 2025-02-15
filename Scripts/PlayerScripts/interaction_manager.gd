# Credits: DashNothing's interact code
# Link: https://youtu.be/ajCraxGAeYU

extends Node2D

@onready var player # is a group name of player
@onready var label = $Label

var active_areas : Array = []
var can_interact : bool = true

func register_area(area : InteractionArea):
	active_areas.push_back(area)

func unregistered_area(area : InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func find_player():
	player = get_tree().get_first_node_in_group("Player")

func _process(_delta):
	if active_areas.size() > 0 && can_interact == true:
		active_areas.sort_custom(sort_dist_to_player)
		label.text = active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 256
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()

func sort_dist_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_squared_to(area1.global_position)
	var area2_to_player = player.global_position.distance_squared_to(area2.global_position)
	
	return area1_to_player < area2_to_player

func _input(event):
	if event.is_action_pressed("accept") && can_interact == true:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			can_interact = true
