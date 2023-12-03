extends Node2D
class_name CatManager

@onready var door = get_tree().get_root().get_node("scene_0/Door") as Door

func _ready():
	door.npc_spawned.connect(_on_npc_spawned)
	
func _on_npc_spawned(npc : Npc):
	npc.ready_for_cat.connect(_on_npc_ready)
	
func _on_npc_ready(npc : Npc):
	var cat = select_nearest_cat(npc.get_cat_point())
	if cat != null:
		cat.approach_customer(npc)
	
func get_all_cats() -> Array:
	var all_cats = get_tree().get_nodes_in_group("cats")
	return all_cats

# selects nearest cat to given npc, returns null if no cats or if they're all busy
func select_nearest_cat(target : Node2D) -> Cat:
	var cats = get_all_cats()
	if cats.is_empty():
		return null
	
	# helps sort cat by distance, ascending
	var sort_by_dist = func(a, b) -> bool:
		if (a.global_position).distance_to(target.global_position) < (b.global_position).distance_to(target.global_position):
			return true
		else:
			return false
		
	cats.sort_custom(sort_by_dist)
	
	for cat in cats:
		cat = cat as Cat 
		if cat.is_idle():
			return cat
	
	return null
