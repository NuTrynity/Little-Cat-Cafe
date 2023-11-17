extends Node

func play_sound(stream : AudioStream):
	var instance = AudioStreamPlayer.new()
	instance.stream = stream
	add_child(instance)
	instance.finished.connect(_remove_node)
	instance.play()

func _remove_node(instance : AudioStreamPlayer):
	instance.queue_free()
