extends Label
@export var price : String
@onready var delete_timer = Timer.new()

func _ready():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT_IN)
	
	tween.tween_property(self, "global_position:y", global_position.y - 256, 1.2)
	
	text = "+ " + price + "$"
	
	add_child(delete_timer)
	delete_timer.wait_time = 1
	delete_timer.one_shot = true
	delete_timer.connect("timeout", on_delete_timeout)
	delete_timer.start()

func on_delete_timeout():
	queue_free()
