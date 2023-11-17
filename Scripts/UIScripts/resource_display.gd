extends VBoxContainer

@export var player_resources : PlayerMealCarry

@onready var money_label = $Money
@onready var rating_label = $Rating

func _process(_delta):
	money_label.text = str(player_resources.money) + "$"
	rating_label.text = str(player_resources.ratings)
