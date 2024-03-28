extends MainScene
@onready var tutorial_node = $TutorialNode

func _ready():
	get_tree().paused = false
	
	InteractionManager.find_player()
	save_loader.save_game()
	gameplay_stream.play()
	$EndDay/GameCondition.day_label.text = "Tutorial Day"
	
	load_scene()
	
	tutorial_node.get_target($Player)
	tutorial_node.label.text = "WASD - Move\nE - Interact"
	
	await get_tree().create_timer(10).timeout
	tutorial_node.get_target($KitchenCounter2)
	tutorial_node.label.text = "Interact with\nthe Pan to Cook"
	$KitchenCounter2/FryPan.connect("on_cooked", test)

func test():
	tutorial_node.get_target($Door.spawn_customer())
	tutorial_node.label.text = "Oh a customer!\nI wonder what\nthey want!"
	await get_tree().create_timer(10).timeout
	tutorial_node.get_target($KitchenCounter/Computer)
	tutorial_node.label.text = "You can buy cats here!\nTry one!"
	await get_tree().create_timer(10).timeout
	tutorial_node.get_target($Player)
	tutorial_node.label.text = "Congratz on finishing\nThe Tutorial"
