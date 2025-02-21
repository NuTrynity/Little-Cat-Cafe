extends Label

var label_speed : float
var time_to_delete : float
var time_to_fade : float
var spawn_y_offset : float

func _ready() -> void:
	$RemoveTimer.wait_time = time_to_delete
	$RemoveTimer.start()
	
	position.x -= size.x / 2
	position.y -= spawn_y_offset

func _physics_process(_delta: float) -> void:
	position.y -= label_speed

func _on_remove_timer_timeout() -> void:
	var tween
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property(self, "modulate", Color(255, 255, 255, 0), time_to_fade)
	
	await tween.finished
	queue_free()
