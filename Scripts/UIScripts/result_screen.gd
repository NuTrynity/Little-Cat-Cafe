extends Control
@export var player_resource : PlayerMealCarry
@export var quota : int

@onready var progress_bar = %ProgressBar
@onready var money = %Money
@onready var update_timer = Timer.new()

var curr_money : int
var curr_rating : float
var clicksfx = load("res://Assets/SFX/click_sfx.ogg")

func _ready():
	progress_bar.max_value = quota

func _process(_delta):
	#progress_bar.value = curr_rating
	progress_bar.value = lerp(progress_bar.value, curr_rating, 0.03)
	money.text = str(curr_money) + " $"
	
	if curr_money < GlobalScript.cash_on_hand:
		curr_money = lerp(curr_money, GlobalScript.cash_on_hand, 0.03)
	
	if curr_rating < player_resource.rating:
		curr_rating += player_resource.rating

func _on_next_day_pressed():
	GlobalScript.days += 1
	SceneChanger.change_scene("res://scene_0.tscn", "slide_left")
	AudioManager.play_sound(clicksfx)
