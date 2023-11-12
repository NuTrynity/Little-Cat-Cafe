extends CharacterBody2D

@export var player_meal_amt : PlayerMealCarry

@onready var interact_area = $InteractionArea

func _ready():
	interact_area.interact = Callable(self, "_on_player_give_meal")

func _on_player_give_meal():
	if player_meal_amt.carry_amt > 0:
		player_meal_amt.give_meal()
	else:
		print('there is not food')
	
	print(player_meal_amt.carry_amt)
