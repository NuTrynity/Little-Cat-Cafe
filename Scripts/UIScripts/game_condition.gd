extends Control

@export var game_manager : GameManager
@onready var animation = $AnimationPlayer

func _ready():
	game_manager.game_end.connect(_play_animation)

func _play_animation():
	show()
	get_tree().paused = true
	animation.play("Game_Over")
