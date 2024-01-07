extends Node2D

@onready var gameplay_music = preload("res://Assets/Music/Gameplay.wav")
@onready var gameplay_stream = $GamePlayMusic
@onready var save_loader = $SaveLoader

func _ready():
	get_tree().paused = false
	
	InteractionManager.find_player()
	save_loader.save_game()
	gameplay_stream.play()
	
	load_scene()

func load_scene():
	load_cats()
	load_objects()

func load_cats():
	var shop = GlobalScript.shop
	for shop_idx in shop:
		for x in range(shop[shop_idx]["owned"]):
			var cat_node = load(shop[shop_idx]["node"])
			var cat = cat_node.instantiate() as Cat
			get_tree().get_root().get_node("scene_0").add_child(cat)
			cat.global_position = cat.aiMvt.choose_random_point()
			#cat.global_position = get_tree().get_root().get_node("scene_0/Door/LeaveArea").global_position
			
func load_objects():
	var items = GlobalScript.items_owned
	
	# spawn tables
	spawn_objects(self, items, "table")
	
	#spawn frypans 
	spawn_objects($KitchenCounter2, items, "frypan")
	
	#spawn coffee machines
	spawn_objects($KitchenCounter, items, "coffee machine")

func spawn_objects(parent: Node2D, items : Dictionary, name : String):
	var objects = items[name]
	var count = objects["owned"]
	for n in range(count):
		var obj_node = load(objects["node"])
		var obj = obj_node.instantiate() as Node2D
		parent.add_child(obj)
		obj.position = objects["positions"][n]
		
