extends AiMovement

@export var cat_speed : int = 150

func _ready():
	speed = cat_speed
	
func _on_timer_timeout():
	pass
