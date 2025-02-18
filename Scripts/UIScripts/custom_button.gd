extends Button

@export var press_once : bool = false
@export var sounds : Array[AudioStream]

var can_press : bool = true

func _ready() -> void:
	pivot_offset.x += size.x / 2
	pivot_offset.y += size.y / 2

func _on_focus_entered() -> void:
	pass # add sound here

func _on_pressed() -> void:
	AudioManager.play_sound(sounds[0])
	
	if can_press:
		if press_once:
			can_press = false
		
		print("Pressed") # Temporary
