extends HBoxContainer

@export var player_resources : PlayerMealCarry

@onready var money_label = $Money
@onready var rating_label = $Rating

func _process(_delta):
	money_label.text = "Money: " + str(GlobalScript.cash_on_hand) + " $"
	rating_label.text = "Rating: " + str(player_resources.rating) + " likes"
