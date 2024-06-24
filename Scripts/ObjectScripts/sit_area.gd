extends Node2D
class_name SitArea

@export var facing_left : bool

# chair vars
var targeted : bool = false
var npc : Node2D = null

@warning_ignore("shadowed_variable")
func set_targeted(npc: Node2D):
	npc = npc
	targeted = true
	
func set_untargeted():
	npc = null
	targeted = false

func is_targeted() -> bool:
	return targeted 
	
func get_cat_point() -> PlacementPoint:
	return $PlacementPoint
