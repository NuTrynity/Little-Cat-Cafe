extends Control
@export var quota : int

@onready var progress_bar = %ProgressBar
@onready var money = %Money
@onready var update_timer = Timer.new()

var curr_money : int
var curr_rating : int
var clicksfx = load("res://Assets/SFX/click_sfx.ogg")

func _ready():
	progress_bar.max_value = quota

func _process(_delta):
	progress_bar.value = curr_rating
	money.text = str(curr_money) + " $"
	
	if curr_money < GlobalScript.cash_on_hand:
		await get_tree().create_timer(0.01).timeout
		curr_money += 10
	
	if curr_rating < GlobalScript.rating:
		await get_tree().create_timer(0.01).timeout
		curr_rating += 10

func _on_next_day_pressed():
	GlobalScript.days += 1
	SceneChanger.change_scene("res://scene_0.tscn", "slide_left")
	AudioManager.play_sound(clicksfx)
