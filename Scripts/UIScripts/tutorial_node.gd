extends Node2D
@onready var text = %Text

func _ready():
	text.global_position.y -= 128

func goto(target_position : Vector2):
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, 0.7)
