extends Node2D

@onready var gameplay_music = preload("res://Assets/Music/Gameplay.wav")
@onready var gameplay_stream = $GamePlayMusic
@onready var ui = $UserInterface/Control/Timer

func _ready():
	InteractionManager.find_player()
	gameplay_stream.play()
