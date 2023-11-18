extends VBoxContainer

@export var player_resources : PlayerMealCarry

@onready var money_label = $Money

func _process(_delta):
	money_label.text = str(player_resources.money) + " $"
