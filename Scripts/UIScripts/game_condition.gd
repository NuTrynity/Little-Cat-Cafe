extends Control

@export var resources : PlayerMealCarry
@export var game_manager : GameManager

@onready var animation = $AnimationPlayer
@onready var timer = Timer.new()
@onready var to_cash_timer = Timer.new()
@onready var cash_label = $Results/Cash/Amt/Result

var click = load("res://Assets/SFX/click_sfx.ogg")
var victory_sfx = load("res://Assets/Music/Good Job!.wav")

func _ready():
	game_manager.game_end.connect(_end_day)
	setup_timer()

func _process(_delta):
	cash_label.text = str(GlobalScript.cash_on_hand)

func setup_timer():
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = 3
	timer.connect("timeout", _next_day)

func _next_day():
	animation.play("Results")

func _end_day():
	timer.start()
	show()
	get_tree().paused = true
	animation.play("Game_Over")
	AudioManager.play_sound(victory_sfx)

func _on_next_day_pressed():
	get_tree().change_scene_to_file("res://Nodes/UI/main_menu.tscn")
	get_tree().paused = false
	AudioManager.play_sound(click)
	resources.money = 0
