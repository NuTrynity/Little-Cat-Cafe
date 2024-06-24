extends HBoxContainer

@export var player_resources : PlayerResource

@onready var money_label = $Money
@onready var rating_label = $Rating

func _process(_delta):
	money_label.text = "Money: " + str(GlobalScript.money) + " $"
	rating_label.text = "Rating: " + str(GlobalScript.ratings) + " likes"
