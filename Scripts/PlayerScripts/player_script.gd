extends CharacterBody2D

@onready var popup_label = preload("res://Nodes/UINodes/PopUp.tscn")

func _ready() -> void:
	# Interaction Manager finds player when player is loaded
	InteractionManager.find_player() 
	
	add_popup()

func add_popup():
	var new_popup = popup_label.instantiate()
	new_popup.popup_text = "1500"
	new_popup.speed = 2
	new_popup.delete_time = 1
	new_popup.fade_time = 0.6
	new_popup.y_offset = 256
	
	new_popup.position = global_position
	new_popup.position.x -= new_popup.size.x / 2 # TODO: Find out why this doesnt work
	
	get_tree().root.add_child.call_deferred(new_popup)
