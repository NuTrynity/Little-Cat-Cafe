extends Node

@export var player_node : CharacterBody2D
@export var player_sprite : Sprite2D
@export var move_speed : int

func _physics_process(_delta: float) -> void:
	player_node.velocity = get_input() * move_speed
	player_node.move_and_slide()

func _process(_delta: float) -> void:
	if !is_zero_approx(player_node.velocity.x):
		if get_input().x < 0:
			player_sprite.flip_h = true
		else:
			player_sprite.flip_h = false

func get_input():
	return Input.get_vector("move_down", "move_right", "move_up", "move_down")
