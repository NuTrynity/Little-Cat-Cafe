extends Node2D

@export var player_resources : PlayerMealCarry
@export var meal_price : float

@onready var meal_sprite = $MealSprite
#@onready var interact_area = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("player")

var picked_up : bool

func _ready():
	#interact_area.interact = Callable(self, "_on_pick_up")
	player_resources.meal_given.connect(give_meal)

func _physics_process(_delta):
	if picked_up == true:
		global_position = player.global_position
		global_position.y -= 128
		#interact_area.monitorable = false
		#interact_area.monitoring = false

func give_meal():
	if picked_up == true:
		player_resources.money += meal_price
		player_resources.carry_amt -= 1
		queue_free()

func _on_pick_up():
	if player_resources.carry_amt < player_resources.max_amt:
		player_resources.carry_amt += 1
		z_index = 1
		picked_up = true
