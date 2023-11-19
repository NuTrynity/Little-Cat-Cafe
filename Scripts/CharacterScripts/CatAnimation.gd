extends Node2D
class_name CatAnimation

@export var sprite_idx : int

@onready var sprite = $CatSprite as Sprite2D
@onready var animations = $AnimationPlayer as AnimationPlayer

var interact_sprite
var walk_sprite 
var sleep_sprite 

func _ready():
	interact_sprite = load("res://Sprites/cat_sprites/cat" + str(sprite_idx) + "_interact.png" ) 
	walk_sprite = load("res://Sprites/cat_sprites/cat" + str(sprite_idx) + "_walk.png" )
	sleep_sprite = load("res://Sprites/cat_sprites/cat" + str(sprite_idx) + "_sleep.png" )
	
func interact():
	sprite.texture = interact_sprite
	animations.play("interact")
	
func walk():
	sprite.texture = walk_sprite
	animations.play("walk")

func idle():
	sprite.texture = walk_sprite
	animations.play("interact")
	
func sleep():
	sprite.texture = sleep_sprite
	animations.play("sleep")
	
	
