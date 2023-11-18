extends Node2D

@onready var interact_area =  $InteractionArea
@onready var progress_bar = $CookingProgress
@onready var brew_timer = Timer.new()

var meal = preload("res://Nodes/Meals/cat_latte.tscn")
var coffee_machine_sfx = load("res://Assets/SFX/coffee_pouring.mp3")
var is_brewing : bool = false

func _ready():
	interact_area.interact = Callable(self, "_on_interact")
	progress_bar.progress_finish.connect(brew_coffee)
	setup_timer()

func setup_timer():
	add_child(brew_timer)
	brew_timer.one_shot = false
	brew_timer.wait_time = 0.1
	brew_timer.connect("timeout", increase_progress)

func increase_progress():
	progress_bar.value += 1

func _on_interact():
	if is_brewing == false:
		brew_timer.start()
		progress_bar.show()
		AudioManager.play_sound(coffee_machine_sfx)
		is_brewing = true
	else:
		print("let him cook!")

func brew_coffee():
	var tablecloth = get_tree().get_root().get_node("scene_0/KitchenCounter2/PickupTablecloth")
	var placement_pts = tablecloth.get_node("PlacementPoints")
	
	var pickup_full = true
	for point in placement_pts.get_children():
		if point.get_is_empty():
			var food = meal.instantiate()
			tablecloth.add_child(food)
			point.add_item(food)
			GlobalScript.inventory[1]["count"] += 1
			pickup_full = false
			is_brewing = false
			brew_timer.stop()
			
			break
	if pickup_full:
		print("can't cook, pickup is full")
