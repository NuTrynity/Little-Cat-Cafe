extends CharacterBody2D

@export var player_stats : PlayerMealCarry
@export var move_speed : float = 500.0

@onready var pivot : Node2D = $PlayerSkin
@onready var start_scale : Vector2 = pivot.scale
@onready var animations = $PlayerSkin/PlayerAnimations
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D

var input = Vector2.ZERO
var click_position = Vector2()
var tap_movement : bool
'''
func _ready():
	click_position = global_position

func _input(event):
	if event.is_action_pressed("click_move"):
		click_position = get_global_mouse_position()
		make_path()
'''
func _physics_process(_delta):
	input = get_input()
	
	velocity = input * move_speed
	move_and_slide()
	
	'''
	if !reached_position():
		var direction = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = direction * move_speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO
	'''
	var is_idle = is_zero_approx(velocity.x) and is_zero_approx(velocity.y)
	var is_walking = not Vector2.ZERO
	
	if is_idle:
		animations.play("idle")
	elif  is_walking:
		animations.play("walking")
	
	if not is_zero_approx(velocity.x):
		pivot.scale.x = sign(velocity.x) * start_scale.x

func get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	return input.normalized()
'''
func make_path() -> void:
	nav_agent.target_position = click_position

func reached_position():
	return nav_agent.distance_to_target() <= 4
'''
