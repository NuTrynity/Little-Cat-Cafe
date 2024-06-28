extends Node2D
class_name PlacementPoint

var held_item : Node2D = null

func _ready():
	remove_item()

func get_is_empty() -> bool:
	return held_item == null
	
func add_item(item:Node2D) -> void:
	held_item = item
	held_item.global_position = global_position
	
func remove_item() -> Node2D:
	var return_item = held_item
	held_item = null
	return return_item
