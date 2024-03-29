extends Node2D
@onready var label = $Label

var target : Node

func _ready():
	label.position.x -= label.size.x / 2
	label.position.y += 32

func _process(_delta):
	if target == null:
		return
	var tween = create_tween()
	tween.tween_property(self, "position", target.global_position, 0.6)

func get_target(new_target : Node):
	target = new_target
