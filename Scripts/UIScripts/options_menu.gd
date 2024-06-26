extends PanelContainer

signal back
@onready var option_loc = "user://options.tres"
@onready var sfx_bus = AudioServer.get_bus_index("SFX")
@onready var music_bus = AudioServer.get_bus_index("Music")
@onready var options = $Options

var click = load("res://Assets/SFX/click_sfx.ogg")
var selected : int

const window_options : Array[String] = [
	"Full-Screen",
	"Window Mode",
	"Borderless Window",
	"Borderless Full-Screen"
]

func _ready() -> void:
	$Menu/Fullscreen/ScreenOption.item_selected.connect(on_window_mode_selected)
	
	if FileAccess.file_exists(option_loc):
		options.load_settings()
	
	if GlobalScript.window_mode == window_options[0]:
		selected = 0
		set_window_mode(0)
	elif GlobalScript.window_mode == window_options[1]:
		selected = 1
		set_window_mode(1)
	elif GlobalScript.window_mode == window_options[2]:
		selected = 2
		set_window_mode(2)
	elif GlobalScript.window_mode == window_options[3]:
		selected = 3
		set_window_mode(3)
	
	$Menu/Sliders/SFX/SFXSlider.value = GlobalScript.sfx_volume
	$Menu/Sliders/Music/MusicSlider.value = GlobalScript.music_volume
	$Menu/Fullscreen/ScreenOption.select(selected)

func hide_options() -> void:
	hide()
	back.emit()

func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		hide_options()

func _on_back_pressed() -> void:
	hide_options()
	AudioManager.play_sound(click)

func _on_sfx_slider_value_changed(value) -> void:
	GlobalScript.sfx_volume = value
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))
	AudioServer.set_bus_mute(sfx_bus, value < 0.1)
	AudioManager.play_sound(click)
	options.save_settings()

func _on_music_slider_value_changed(value) -> void:
	GlobalScript.music_volume = value
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))
	AudioServer.set_bus_mute(music_bus, value < 0.1)
	options.save_settings()

func on_window_mode_selected(index : int) -> void:
	
	match index:
		0:
			set_window_mode(0)
		1:
			set_window_mode(1)
		2:
			set_window_mode(2)
		3:
			set_window_mode(3)
	
	options.save_settings()

func set_window_mode(index : int) -> void:
	if index == 0:
		GlobalScript.window_mode = window_options[0]
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	elif index == 1:
		GlobalScript.window_mode = window_options[1]
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	elif index == 2:
		GlobalScript.window_mode = window_options[2]
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	elif index == 3:
		GlobalScript.window_mode = window_options[3]
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
