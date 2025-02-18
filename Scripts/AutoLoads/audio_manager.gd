extends Node

const sfx_bus = "SFX"

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS

func play_sound(stream : AudioStream):
	var instance = AudioStreamPlayer.new()
	instance.stream = stream
	instance.bus = sfx_bus
	instance.finished.connect(_remove_node.bind(instance))
	add_child(instance)
	instance.play()

func _remove_node(instance : AudioStreamPlayer):
	instance.queue_free()
