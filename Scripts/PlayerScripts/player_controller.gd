extends Node

@export var player : CharacterBody2D
@export var move_speed : int

func _physics_process(_delta: float) -> void:
	player.velocity = get_input() * move_speed
	player.move_and_slide()

func get_input():
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")
