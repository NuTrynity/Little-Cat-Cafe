extends Node2D

@onready var interact_area = $InteractionArea
@onready var progress_bar = $CookingProgress
@onready var cook_timer = Timer.new()

var omurice = preload("res://Nodes/Meals/omurice.tscn")
var cooking_sfx = load("res://Assets/SFX/pan_frying_edit.mp3")
var is_cooking : bool = false

func _ready():
	interact_area.interact = Callable(self, "_on_interaction")
	progress_bar.progress_finish.connect(cook_meal)
	setup_timer()

func setup_timer():
	add_child(cook_timer)
	cook_timer.one_shot = false
	cook_timer.wait_time = 0.1
	cook_timer.connect("timeout", increase_progress)

func _on_interaction():
	if is_cooking == false:
		cook_timer.start()
		progress_bar.show()
		AudioManager.play_sound(cooking_sfx)
		is_cooking = true

func increase_progress():
	progress_bar.value += 1

func cook_meal():
	var tablecloth = get_tree().get_root().get_node("scene_0/KitchenCounter2/PickupTablecloth")
	var placement_pts = tablecloth.get_node("PlacementPoints")
	
	var pickup_full = true
	for point in placement_pts.get_children():
		if point.get_is_empty():
			var food = omurice.instantiate()
			tablecloth.add_child(food)
			point.add_item(food)
			GlobalScript.inventory[0]["count"] += 1
			pickup_full = false
			is_cooking = false
			cook_timer.stop()
			
			break
	if pickup_full:
		print("can't cook, pickup is full")
