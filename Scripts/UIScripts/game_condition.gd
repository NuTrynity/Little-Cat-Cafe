extends Control

@export var resources : PlayerMealCarry
@export var game_manager : GameManager
@onready var animation = $AnimationPlayer

func _ready():
	game_manager.game_end.connect(_end_day)

func _end_day():
	GlobalScript.cash_on_hand += resources.money
	
	show()
	get_tree().paused = true
	animation.play("Game_Over")
