extends Node2D

@onready var gameplay_music = preload("res://Assets/Music/Gameplay.wav")
@onready var gameplay_strea = $GamePlayMusic

func _ready():
	InteractionManager.find_player()
	gameplay_strea.play()
