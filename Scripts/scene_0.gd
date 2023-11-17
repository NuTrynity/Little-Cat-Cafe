extends Node2D

@onready var gameplay_music = preload("res://Assets/Music/Gameplay.wav")
@onready var gameplay_strea = $GamePlayMusic
@onready var ui = $UserInterface/Control/Timer

func _ready():
	InteractionManager.find_player()
	gameplay_strea.play()
	ui.timer_reached.connect(_game_over)

func _game_over():
	print("game is over!")
