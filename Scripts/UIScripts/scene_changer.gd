extends CanvasLayer
@onready var animations = $Animations
'''
DEPRECATED: USE SCENEMANAGER INSTEAD :3
'''
var scene : String
func change_scene(target : String, anim : String):
	scene = target
	animations.play(anim)

func change_now():
	get_tree().change_scene_to_file(scene)
