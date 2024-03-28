extends Control
@export var player_resource : PlayerMealCarry

@onready var progress_bar = %ProgressBar
@onready var money = %Money
@onready var update_timer = Timer.new()

var clicksfx = load("res://Assets/SFX/click_sfx.ogg")
var victory_music = load("res://Assets/Music/Good Job!.wav")

func _ready():
	progress_bar.max_value = player_resource.quota
	
	money.text = str(GlobalScript.cash_on_hand) + " $"
	progress_bar.value = player_resource.rating
	
	##Items Owned Sections##
	%cats.text = "Cats Owned: " + str(count_all(GlobalScript.shop))
	%tables.text = "Tables Owned: " + str(count_specific(GlobalScript.items_owned["table"]))
	%chefcat.text = "Chef Cats Owned: " + str(count_specific(GlobalScript.shop[0]))
	%greycat.text = "Grey Cats Owned: " + str(count_specific(GlobalScript.shop[1]))
	%tabbycat.text = "Tabby Cats Owned: " + str(count_specific(GlobalScript.shop[2]))
	%browncat.text = "Brown Cats Owned: " + str(count_specific(GlobalScript.shop[3]))
	%orangecat.text = "Orange Cats Owned: " + str(count_specific(GlobalScript.shop[4]))
	##Items Owned Sections##

func count_all(data): #Counts all owned items in a Dictionary
	var amt : int = 0
	var items = data
	for item_index in items:
		for x in range(items[item_index]["owned"]):
			amt += 1
	return amt

func count_specific(data): #Counts only a specific owned item in a Dictionary
	var amt : int = 0
	for x in range(data["owned"]):
		amt += 1
	return amt

func _on_next_day_pressed():
	GlobalScript.days += 1
	SceneChanger.change_scene("res://scene_0.tscn", "slide_left")
	AudioManager.play_sound(clicksfx)
