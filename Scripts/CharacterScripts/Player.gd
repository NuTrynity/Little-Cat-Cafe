extends CharacterBody2D

@export var move_speed = 300.0

var input = Vector2.ZERO

func get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	return input.normalized()

func _physics_process(delta):
	input = get_input()
	
	velocity = (input * move_speed)
	move_and_slide()
