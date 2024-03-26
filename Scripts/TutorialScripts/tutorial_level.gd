extends Node2D
@onready var tutorial_node = $TutorialNode
@onready var player = $Player
@onready var gameplay_stream = $GamePlayMusic

# This is the Tutorial Script
func _ready():
	get_tree().paused = false
	
	InteractionManager.find_player()
	tutorial_node.text.text = "- W A S D\n to Move"
	$EndDay/GameCondition.day_label.text = "Tutorial Day"
	tutorial_node.goto(player.position)
	gameplay_stream.play()
	
	load_scene()

func load_scene():
	load_objects()

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
