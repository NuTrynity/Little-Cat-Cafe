extends Control
@export var player_resource : PlayerMealCarry
@export var quota : int

@onready var progress_bar = %ProgressBar
@onready var money = %Money
@onready var update_timer = Timer.new()

var curr_money : int
var curr_rating : int
var clicksfx = load("res://Assets/SFX/click_sfx.ogg")
var victory_music = load("res://Assets/Music/Good Job!.wav")

func _ready():
	progress_bar.max_value = quota
	player_resource.rating = quota

func _process(delta):
	progress_bar.value = curr_rating
	money.text = str(curr_money) + " $"
	
	if curr_money < GlobalScript.cash_on_hand:
		curr_money += 10

	if curr_rating < player_resource.rating:
		curr_rating += 50
		
		if curr_rating >= quota:
			AudioManager.play_sound(victory_music)

func _on_next_day_pressed():
	GlobalScript.days += 1
	SceneChanger.change_scene("res://scene_0.tscn", "slide_left")
	AudioManager.play_sound(clicksfx)
