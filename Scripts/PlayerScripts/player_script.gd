extends CharacterBody2D

@onready var popup_label = preload("res://Nodes/UINodes/PopUp.tscn")

func _ready() -> void:
	# Interaction Manager finds player when player is loaded
	InteractionManager.find_player()
