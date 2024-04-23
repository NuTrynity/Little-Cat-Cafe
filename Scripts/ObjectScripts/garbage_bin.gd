extends Node2D

@export var player_resources : PlayerMealCarry

@onready var interact_area = $InteractionArea
var meal_wanted = null

func _ready():
	interact_area.interact = Callable(self, "_toss_item")

func _toss_item():
	player_resources.give_meal(self)

func grab_meal(meal):
	var idx = meal.meal_index
	GlobalScript.inventory[idx]["count"] -= 1
	if GlobalScript.inventory[idx]["count"] < 0:
		GlobalScript.inventory[idx]["count"] = 0
	
	player_resources.carry_amt -= 1
	meal.queue_free()
