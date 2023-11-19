extends Control

@export var resources : PlayerMealCarry
@export var game_manager : GameManager
@onready var animation = $AnimationPlayer
@onready var timer = Timer.new()
@onready var to_cash_timer = Timer.new()
@onready var money_label = $Results/Money/Amt/Result
@onready var cash_label = $Results/Cash/Amt/Result

func _ready():
	game_manager.game_end.connect(_end_day)
	setup_timer()

func _process(_delta):
	money_label.text = str(resources.money)
	cash_label.text = str(GlobalScript.cash_on_hand)

func setup_timer():
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = 3
	timer.connect("timeout", _next_day)
	
	add_child(to_cash_timer)
	to_cash_timer.one_shot = false
	to_cash_timer.wait_time = 0.0001
	to_cash_timer.connect("timeout", _increase_cash)

func _increase_cash():
	if resources.money != 0:
		GlobalScript.cash_on_hand += 5
		resources.money -= 5
	else:
		to_cash_timer.stop()

func _next_day():
	animation.play("Results")
	
	await animation.animation_finished
	to_cash_timer.start()

func _end_day():
	timer.start()
	show()
	get_tree().paused = true
	animation.play("Game_Over")

func _on_next_day_pressed():
	get_tree().change_scene_to_file("res://scene_0.tscn")
	get_tree().paused = false
