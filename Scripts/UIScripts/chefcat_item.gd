extends CatItem

@onready var chef_spawn = get_tree().get_root().get_node("scene_0/ChefCatSpawn")

func _ready():
	item_node = load(item_node_path)
	setup_item()
	
func _on_btn_pressed():
	if enough_money():
		buy_item()
		spawn_chef_cat()
		
func spawn_chef_cat():
	var cat_instance = item_node.instantiate() as Node2D
	get_tree().get_root().get_node("scene_0").add_child(cat_instance)
	cat_instance.global_position = chef_spawn.global_position
