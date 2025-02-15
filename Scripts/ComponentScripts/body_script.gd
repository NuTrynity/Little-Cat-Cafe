extends Node

@onready var body_sprite = $BodySprite
@export var body : CharacterBody2D
@export var sprite : CompressedTexture2D

var tween

func _ready() -> void:
	body_sprite.texture = sprite

func _process(_delta: float) -> void:
	flip_sprite()

func flip_sprite():
	if !is_zero_approx(body.velocity.x):
		tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_IN)
		
		if body.velocity.x < 0:
			tween.tween_property(body_sprite, "scale", Vector2(-1, 1), 0.2)
		else:
			tween.tween_property(body_sprite, "scale", Vector2(1, 1), 0.2)
