extends Node2D

@export var player_carry : PlayerMealCarry

@onready var interact_area = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("player")

var picked_up : bool

func _ready():
	interact_area.interact = Callable(self, "_on_pick_up")

func _physics_process(delta):
	var speed : float = 500.0
	var velocity = Vector2.ZERO
	
	if picked_up == true:
		pass #TODO: MAKE THE MEAL FLY TOWARDS THE PLAYER POSITION

func _on_pick_up():
	if player_carry.carry_amt < player_carry.max_carry_amt:
		player_carry.carry_amt += 1
		picked_up = true
	
	print(player_carry.carry_amt)
