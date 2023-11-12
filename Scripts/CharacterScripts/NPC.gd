extends CharacterBody2D

@export var player_resources : PlayerMealCarry

@onready var interact_area = $InteractionArea

func _ready():
	interact_area.interact = Callable(self, "_on_player_give_meal")

func _on_player_give_meal():
	if player_resources.carry_amt > 0:
		player_resources.give_meal()
	else:
		player_resources.ratings -= 1
	
	print(player_resources.carry_amt)
