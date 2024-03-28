extends Node2D
@onready var label = $Label

var target : Vector2

func _process(_delta):
	var tween = create_tween()
	tween.tween_property(self, "position", target, 0.6)

func goto(new_target : Vector2):
	target = new_target
