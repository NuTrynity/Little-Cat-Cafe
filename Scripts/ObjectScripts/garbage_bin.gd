extends Node2D

@export var player_resources : PlayerMealCarry

@onready var interact_area = $InteractionArea

func _ready():
	interact_area.interact = Callable(self, "_toss_item")

func _toss_item():
	player_resources.give_meal(self)
	
func grab_meal(meal):
	for i in GlobalScript.inventory:
		if GlobalScript.inventory[i]["count"] > 0:
			GlobalScript.inventory[i]["count"] -= 1
			player_resources.carry_amt -= 1
			meal.queue_free()
	print(GlobalScript.inventory)
