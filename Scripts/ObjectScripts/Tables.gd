extends Node2D

@export var tables_owned : float = 3

@onready var tables = get_children()

func get_available_table() -> Area2D:
	for table in tables:
		if table.customer == null: #make a script for the table if they hold a customer
			return table
	return null
