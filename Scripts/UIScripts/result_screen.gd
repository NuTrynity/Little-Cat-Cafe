extends Control
@export var player_resource : PlayerMealCarry
@export var quota : int

@onready var progress_bar = %ProgressBar
@onready var money = %Money
@onready var update_timer = Timer.new()

var clicksfx = load("res://Assets/SFX/click_sfx.ogg")
var victory_music = load("res://Assets/Music/Good Job!.wav")

func _ready():
	progress_bar.max_value = quota
	
	money.text = str(GlobalScript.cash_on_hand) + " $"
	progress_bar.value = player_resource.rating

func _on_next_day_pressed():
	GlobalScript.days += 1
	SceneChanger.change_scene("res://scene_0.tscn", "slide_left")
	AudioManager.play_sound(clicksfx)
