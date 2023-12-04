extends Node2D

@onready var gameplay_music = preload("res://Assets/Music/Gameplay.wav")
@onready var gameplay_stream = $GamePlayMusic
@onready var ui = $UserInterface/Control/Timer

func _ready():
	get_tree().paused = false
	InteractionManager.find_player()
	gameplay_stream.play()
	
	load_cats()

func load_cats():
	var shop = GlobalScript.shop
	for shop_idx in shop:
		for x in range(shop[shop_idx]["owned"]):
			var cat_node = load(shop[shop_idx]["node"])
			var cat = cat_node.instantiate() as Cat
			get_tree().get_root().get_node("scene_0").add_child(cat)
			cat.global_position = cat.aiMvt.choose_random_point()
			#cat.global_position = get_tree().get_root().get_node("scene_0/Door/LeaveArea").global_position
