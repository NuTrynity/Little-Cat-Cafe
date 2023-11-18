extends PanelContainer

signal back
@onready var sfx_bus = AudioServer.get_bus_index("SFX")
@onready var music_bus = AudioServer.get_bus_index("Music")

func _on_back_pressed():
	hide()
	back.emit()

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))
	AudioServer.set_bus_mute(sfx_bus, value < 0.1)

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))
	AudioServer.set_bus_mute(music_bus, value < 0.1)
