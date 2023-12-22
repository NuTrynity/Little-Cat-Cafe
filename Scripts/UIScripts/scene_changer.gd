extends CanvasLayer

@onready var animations = $Animations
@onready var sprite = $Sprite

func change_scene(target : String, anim : String):
	var img = get_viewport().get_texture().get_image()
	var screenshot = ImageTexture.create_from_image(img)
	img.flip_y()
	sprite.texture = screenshot
	animations.play(anim)
	get_tree().change_scene_to_file(target)
