extends Node2D

@export var player_carry : Resource

@onready var interaction_area = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_on_pick_up")

func _on_pick_up():
	if player_carry.carry_amt < player_carry.max_carry_amt:
		player_carry.carry_amt += 1
		queue_free()
	
	print(player_carry.carry_amt, " " , player_carry.max_carry_amt)
