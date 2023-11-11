extends CharacterBody2D

@export var cat_sheet : Array

var randomizer = RandomNumberGenerator.new()

#this randomizes the color of the cats :D
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		change_color()

func change_color():
	var rando_color = randomizer.randi_range(0, 2)
	$CatSprite.modulate = cat_sheet[rando_color]
	print(rando_color)
