extends CharacterBody2D

@onready var interaction_area = $InteractionArea

func _ready() -> void:
	interaction_area.interact = Callable(self, "on_interact")

func on_interact():
	popUp_notif("Hello World", 312)

func popUp_notif(text_label : String, y_offset : float):
	var popUp = preload("res://Nodes/UINodes/PopUp.tscn")
	var new_popUp = popUp.instantiate()
	
	new_popUp.text = text_label
	new_popUp.label_speed = 2.0
	new_popUp.time_to_delete = 2
	new_popUp.time_to_fade = 0.6
	new_popUp.spawn_y_offset = y_offset
	new_popUp.position = global_position
	
	get_parent().add_child(new_popUp)
