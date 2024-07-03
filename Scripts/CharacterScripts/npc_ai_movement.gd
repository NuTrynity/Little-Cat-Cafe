extends AiMovement
class_name NpcAiMovement

@export var table_manager : TableManager
@export var npc_speed : int = 150
@onready var door = get_tree().get_root().get_node("scene_0/Door")

func _ready():
	speed = npc_speed

func goto_exit():
	untarget_chair()
	target = door
	makepath()

# tries to find a target, returns null if there is none
func find_and_pick_target():
	var chair = pick_chair()
	if chair != null:
		target = chair
		return chair
	
	# can put other activities here (ex. going to cat-petting area)
	
	return null

# returns a sit_area node, returns null if no chairs are available
func pick_chair() -> Node2D:
	var sit_areas = get_tree().get_nodes_in_group("chair")
	
	for sit_area in sit_areas:
		if !sit_area.is_targeted():
			sit_area.set_targeted(get_parent())
			return sit_area
	return null
		
func untarget_chair():
	if target != null:
		target.set_untargeted()
	
