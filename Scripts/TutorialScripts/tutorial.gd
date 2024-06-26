extends MainScene
@onready var tutorial_node = $TutorialNode

var cooked : bool = false
var bought : bool = false

var game_timer

func _ready():
	get_tree().paused = false
	
	InteractionManager.find_player()
	save_loader.save_game()
	gameplay_stream.play()
	$EndDay/GameCondition.day_label.text = "Tutorial Day"
	
	load_scene()
	
	game_timer = $UserInterface/MarginContainer/Container/Essentials/Timer
	game_timer.timer.paused = true
	game_timer.visible = false
	
	await get_tree().create_timer(2).timeout
	tutorial_node.get_target($Player)
	tutorial_node.label.text = "Use WASD to Move\nPress E to Interact"
	
	await get_tree().create_timer(6).timeout
	tutorial_node.get_target($KitchenCounter2)
	tutorial_node.label.text = "Interact with\nthe Pan to Cook"
	$KitchenCounter2/FryPan.connect("on_cooked", _on_spawn_first_customer, )
	
func _on_spawn_first_customer():
	if cooked:
		return
	cooked = true
	
	await get_tree().create_timer(1).timeout
	var customer = $Door.spawn_customer()
	customer.connect("leaving", _on_customer_leaving)
	
	tutorial_node.get_target(customer)
	tutorial_node.label.text = "Oh a customer!\nI wonder what\nthey want!"
	await get_tree().create_timer(6.8).timeout
	
	tutorial_node.label.text = "Serve them the food you made!"
	await get_tree().create_timer(4).timeout
	tutorial_node.label.text = ""
	
func _on_customer_leaving():
	tutorial_node.get_target($KitchenCounter/Computer)
	tutorial_node.label.text = "You can buy cats at the PC!\nTry it!"
	$PC/Shop/PanelContainer/VBoxContainer/ScrollContainer/ShopItems.connect("item_bought", _on_item_bought)
	
	
func _on_item_bought():
	if bought:
		return
	bought = true
	
	tutorial_node.label.text = ""
	await get_tree().create_timer(4).timeout
	var customer = $Door.spawn_customer()
	customer.connect("leaving", _on_last_customer_leaving)
	
	tutorial_node.get_target($Player)
	tutorial_node.label.text = "Serve the next customer!"
	await get_tree().create_timer(4).timeout
	tutorial_node.label.text = ""
	
func _on_last_customer_leaving():
	game_timer.set_to_zero()
	tutorial_node.get_target($Player)
	tutorial_node.label.text = "Congrats on finishing\nThe Tutorial!"
	await get_tree().create_timer(4).timeout
	tutorial_node.label.text = ""

	
