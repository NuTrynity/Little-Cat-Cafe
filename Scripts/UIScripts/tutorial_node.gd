extends Node2D
@onready var text = $Text

func _ready():
	text.global_position.y -= 240

func goto(target_position : Vector2):
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, 1)

func show_tutorial():
	pass # make text about stuff

func tutorial_finish():
	pass # when player does the tutorial
