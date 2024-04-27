extends PanelContainer

signal back
@onready var option_loc = "user://options.tres"
@onready var sfx_bus = AudioServer.get_bus_index("SFX")
@onready var music_bus = AudioServer.get_bus_index("Music")
@onready var options = $Options

var click = load("res://Assets/SFX/click_sfx.ogg")

func _ready():
	if FileAccess.file_exists(option_loc):
		options.load_settings()
	
	$Menu/Sliders/SFX/SFXSlider.value = GlobalScript.sfx_volume
	$Menu/Sliders/Music/MusicSlider.value = GlobalScript.music_volume
	
	if GlobalScript.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func hide_options():
	hide()
	back.emit()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		hide_options()

func _on_back_pressed():
	hide_options()
	AudioManager.play_sound(click)

func _on_sfx_slider_value_changed(value):
	GlobalScript.sfx_volume = value
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))
	AudioServer.set_bus_mute(sfx_bus, value < 0.1)
	AudioManager.play_sound(click)
	options.save_settings()

func _on_music_slider_value_changed(value):
	GlobalScript.music_volume = value
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))
	AudioServer.set_bus_mute(music_bus, value < 0.1)
	options.save_settings()

func _on_check_button_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		GlobalScript.fullscreen = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		GlobalScript.fullscreen = false
	
	AudioManager.play_sound(click)
	options.save_settings()
