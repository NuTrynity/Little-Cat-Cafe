extends CanvasLayer
@onready var animations = $Animations
@onready var sprite = $Sprite
'''
Case Sensitive! make sure anim parameter has correct spelling and
exists on animation player node when calling this function
'''
func change_scene(target : String, anim : String):
	var img = get_viewport().get_texture().get_image()
	var screenshot = ImageTexture.create_from_image(img)
	img.flip_y()
	sprite.texture = screenshot
	animations.play(anim)
	get_tree().change_scene_to_file(target)
