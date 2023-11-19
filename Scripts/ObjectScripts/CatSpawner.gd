extends Node2D

var grey_cats = load("res://Nodes/CharacterNodes/grey_cat.tscn")

func _ready():
	spawn_greycats()

func spawn_greycats():
	var cats = grey_cats.instantiate()
	cats.global_position = global_position
	add_child.call_deferred(cats)
