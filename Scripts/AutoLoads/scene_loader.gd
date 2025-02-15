extends CanvasLayer

@onready var player : AnimationPlayer = $TransitionPlayer
var scene : String
var animation : String

func transition_to(target : String, target_anim : String):
	scene = target
	animation = target_anim
	player.play(animation)

func _change_scene():
	get_tree().change_scene_to_file(scene)
	_transition_out()

func _transition_out():
	player.play_backwards(animation)
