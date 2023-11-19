extends Control

@export var resources : PlayerMealCarry
@export var game_manager : GameManager
@onready var animation = $AnimationPlayer
@onready var timer = Timer.new()

func _ready():
	game_manager.game_end.connect(_end_day)
	setup_timer()

func setup_timer():
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = 5
	timer.connect("timeout", _next_day)

func _next_day():
	get_tree().change_scene_to_file("res://Nodes/UI/main_menu.tscn")
	get_tree().paused = false

func _end_day():
	GlobalScript.cash_on_hand += resources.money
	resources.money = 0
	timer.start()
	show()
	get_tree().paused = true
	animation.play("Game_Over")
