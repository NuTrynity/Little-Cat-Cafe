extends Node2D

@export var player_carry : PlayerMealCarry

@onready var interact_area = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("player")

var picked_up : bool

func _ready():
	interact_area.interact = Callable(self, "_on_pick_up")
	player_carry.meal_given.connect(delete_self)

func _physics_process(_delta):
	if picked_up == true:
		global_position = player.global_position
		interact_area.monitorable = false
		interact_area.monitoring = false

func delete_self():
	if picked_up == true:
		queue_free()

func _on_pick_up():
	if player_carry.carry_amt < player_carry.max_carry_amt:
		player_carry.carry_amt += 1
		picked_up = true
	
	print(player_carry.carry_amt)
