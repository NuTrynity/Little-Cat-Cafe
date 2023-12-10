extends Control

@export var resources : PlayerMealCarry
@export var game_manager : GameManager
@export var qouta : int

@onready var animation = $AnimationPlayer
@onready var timer = Timer.new()
@onready var money_label = $Results/Money/Amt/Result
@onready var ratings = $Results/Label/RatingBar
@onready var day_label = $DayLabel

var click = load("res://Assets/SFX/click_sfx.ogg")
var victory_sfx = load("res://Assets/Music/Good Job!.wav")

func _ready():
	game_manager.day_end.connect(_end_day)
	ratings.max_value = qouta
	
	setup_timer()
	next_day()

func _process(_delta):
	money_label.text = "$ " + str(GlobalScript.cash_on_hand)
	ratings.value = GlobalScript.rating
	day_label.text = "DAY " + str(game_manager.days)

func setup_timer():
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = 3
	timer.connect("timeout", day_finished)

func next_day():
	animation.play("day_counter")
	await animation.animation_finished
	hide()

func day_finished():
	animation.play("Results")

func _end_day():
	timer.start()
	show()
	get_tree().paused = true
	animation.play("Game_Over")
	AudioManager.play_sound(victory_sfx)
	game_manager._reset()
	resources.carry_amt = 0

func _on_next_day_pressed():
	get_tree().reload_current_scene()
	AudioManager.play_sound(click)
	game_manager.days += 1
