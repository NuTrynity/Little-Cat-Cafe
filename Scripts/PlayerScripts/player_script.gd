extends CharacterBody2D

func _ready() -> void:
	# Interaction Manager finds player when player is loaded
	InteractionManager.find_player() 
