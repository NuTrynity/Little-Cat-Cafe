extends Node2D

@export var player_resources : PlayerMealCarry

@onready var interact_area = $InteractionArea

func _ready():
	interact_area.interact = Callable(self, "_toss_item")

func _toss_item():
	player_resources.give_meal(self)
	
func grab_meal(meal):
	player_resources.carry_amt -= 1
	meal.queue_free()
	print("tossed item")
