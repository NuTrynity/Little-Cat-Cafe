extends Control

@export var resources : PlayerMealCarry
@export var game_manager : GameManager

@onready var animation = $AnimationPlayer

var click = load("res://Assets/SFX/click_sfx.ogg")
var victory_sfx = load("res://Assets/Music/Good Job!.wav")
var current_qouta : float = 0
var game_finished : bool = false

func _ready():
	game_manager.day_end.connect(_end_day)
	$DayLabel.text = "Day: " + str(GlobalScript.days)
	next_day()

func next_day():
	animation.play("day_counter")
	await animation.animation_finished
	hide()

func _end_day():
	show()
	resources.carry_amt = 0
	animation.play("Game_Over")
	game_manager._reset()
	AudioManager.play_sound(victory_sfx)
	
	await get_tree().create_timer(5).timeout
	SceneChanger.change_scene("res://Nodes/UI/result_screen.tscn", "slide_left")
