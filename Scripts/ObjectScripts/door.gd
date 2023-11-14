extends Node2D

var npc = preload("res://Nodes/CharacterNodes/npc.tscn")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		spawn_customer()

func spawn_customer():
	var customer = npc.instantiate()
	customer.position = global_position
	customer.position.y += 100
	get_parent().add_child(customer)
