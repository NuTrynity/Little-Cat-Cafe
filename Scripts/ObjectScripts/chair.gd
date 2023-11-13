extends Area2D

@export var table_manager : TableManager
@export var chair_flipped : bool

@onready var chair_sprite = $ChairSprite

func _ready():
	if chair_flipped == true:
		chair_sprite.flip_h = true
