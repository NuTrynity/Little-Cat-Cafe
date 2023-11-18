extends Node2D

@export var meal_index : int
@export var player_resources : PlayerMealCarry

@onready var meal_sprite = $MealSprite
@onready var player = get_tree().get_first_node_in_group("player")
#@onready var interact_area = $InteractionArea

var picked_up : bool
var meal_price : float

func _ready():
	#interact_area.interact = Callable(self, "_on_pick_up")
	player_resources.meal_given.connect(give_meal)
	print(GlobalScript.meal_types[meal_index]["price"])

func _physics_process(_delta):
	if picked_up == true:
		global_position = player.global_position
		global_position.y -= 128
		#interact_area.monitorable = false
		#interact_area.monitoring = false

func give_meal(_obj):
	if picked_up == true:
		queue_free()

#func _on_pick_up():
#	if player_resources.carry_amt < player_resources.max_amt:
#		player_resources.carry_amt += 1
#		z_index = 1
#		picked_up = true
