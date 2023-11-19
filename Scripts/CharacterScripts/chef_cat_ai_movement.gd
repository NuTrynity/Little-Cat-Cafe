extends CatAiMovement

func _ready():
	nav_mesh = get_tree().get_root().get_node("scene_0/ChefNavigationRegion")
	setup_cat_aimvt()
