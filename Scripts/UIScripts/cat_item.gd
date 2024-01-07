extends ShopItem
class_name CatItem

@export var item_node_path = "res://Nodes/CharacterNodes/grey_cat.tscn"
@export var dict_idx : int

var item_node : Resource

func _ready():
	item_node = load(item_node_path)
	setup_item()

func _on_btn_pressed():
	if enough_money():
		buy_item()
		spawn_cat(item_node)
		
		GlobalScript.shop[dict_idx]["owned"] += 1
		
func spawn_cat(cat_node):
	var cat_instance = cat_node.instantiate() as Node2D
	get_tree().get_root().get_node("scene_0").add_child(cat_instance)
	cat_instance.global_position = leave_area.global_position

func get_max_amt() -> int:
	return 999
	
