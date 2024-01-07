extends ShopItem
class_name CafeItem

@onready var item = GlobalScript.items_owned[item_name]

func _ready():
	setup_item()
	buy_amt = item["owned"]
	
func _on_btn_pressed():
	if enough_money():
		buy_item()
		
		spawn_item()
	
func spawn_item():
	var item_node = load(item["node"])
	var parent = get_tree().get_root().get_node(item["parent_name"])
	var item_instance = item_node.instantiate() as Node2D
	parent.add_child(item_instance)
	
	var idx = item["owned"]
	item_instance.position = item["positions"][idx]
	item["owned"] += 1

func get_max_amt() -> int:
	var positions = item["positions"] as Array
	return positions.size()
	
