extends PanelContainer

signal back
@export var game_manager : GameManager
@onready var sfx_bus = AudioServer.get_bus_index("SFX")
@onready var music_bus = AudioServer.get_bus_index("Music")

var click = load("res://Assets/SFX/click_sfx.ogg")

func _ready():
	$Menu/Sliders/SFX/SFXSlider.value = game_manager.sfx_volume
	$Menu/Sliders/Music/MusicSlider.value = game_manager.music_volume

func _on_back_pressed():
	hide()
	back.emit()
	AudioManager.play_sound(click)

func _on_sfx_slider_value_changed(value):
	game_manager.sfx_volume = value
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))
	AudioServer.set_bus_mute(sfx_bus, value < 0.1)
	AudioManager.play_sound(click)

func _on_music_slider_value_changed(value):
	game_manager.music_volume = value
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))
	AudioServer.set_bus_mute(music_bus, value < 0.1)

func _on_check_button_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	AudioManager.play_sound(click)
