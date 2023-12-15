extends CanvasLayer

@onready var animations = $Animations

func change_scene(target : String) -> void:
	animations.play("dissolve")
	await animations.animation_finished
	get_tree().change_scene_to_file(target)
	animations.play_backwards("dissolve")
