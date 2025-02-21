extends Node

@onready var body_sprite = $BodySprite
@export var body : CharacterBody2D
@export var sprite : CompressedTexture2D

var tween
var facing_left : bool = false

func _ready() -> void:
	body_sprite.texture = sprite

func _process(_delta: float) -> void:
	if !is_zero_approx(body.velocity.x):
		flip_sprite()
		if body.velocity.x < 0:
			facing_left = true
		else:
			facing_left = false
	
	tilt()

func flip_sprite() -> void:
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	
	if facing_left:
		tween.tween_property(body_sprite, "scale", Vector2(-1, 1), 0.2)
	else:
		tween.tween_property(body_sprite, "scale", Vector2(1, 1), 0.2)

func tilt() -> void:
	var max_y_velocity : int = 500
	var max_rotation_angle : float = 6.0
	var rotation_angle = (body.velocity.y / max_y_velocity) * max_rotation_angle
	rotation_angle = clamp(rotation_angle, -max_y_velocity, max_rotation_angle)
	
	if facing_left:
		rotation_angle *= -1
	
	body_sprite.rotation_degrees = rotation_angle
