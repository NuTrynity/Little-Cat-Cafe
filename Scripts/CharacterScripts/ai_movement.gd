extends Node2D
class_name AiMovement

@export var speed : int

@onready var target : Node2D

@onready var body := get_parent() as CharacterBody2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

# call in process
func approach_target():
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	body.velocity = dir * speed
	# if nav_agent.distance_to_target() > 4:
	body.move_and_slide()

func reached_target() -> bool:
	return nav_agent.distance_to_target() <= 4

func makepath() -> void:
	nav_agent.target_position = target.global_position

