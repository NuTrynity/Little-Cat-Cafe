extends Node

const sfx_bus = "SFX"

func play_sound(stream : AudioStream):
	var instance = AudioStreamPlayer.new()
	instance.stream = stream
	instance.volume_db = 16
	instance.bus = sfx_bus
	instance.finished.connect(_remove_node.bind(instance))
	add_child(instance)
	instance.play()

func _remove_node(instance : AudioStreamPlayer):
	instance.queue_free()
