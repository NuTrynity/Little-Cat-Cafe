extends Button

@onready var btn_anim : AnimationPlayer = $BtnAnim
@export var press_once : bool = false

var can_press : bool = true

func _ready() -> void:
	pivot_offset.x += size.x / 2
	pivot_offset.y += size.y / 2

func _on_focus_entered() -> void:
	btn_anim.play("focus")

func _on_focus_exited() -> void:
	btn_anim.play_backwards("focus")

func _on_pressed() -> void:
	btn_anim.play("pressed")
	
	if can_press:
		if press_once:
			can_press = false
		
		print("Pressed") # Temporary
