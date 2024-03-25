extends CanvasLayer
@onready var animations = $Animations
'''
Case Sensitive! make sure anim parameter has correct spelling and
exists on animation player node when calling this function
'''
var scene : String
func change_scene(target : String, anim : String):
	scene = target
	animations.play(anim)

func change_now():
	get_tree().change_scene_to_file(scene)
