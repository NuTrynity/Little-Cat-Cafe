extends Label

@export var popup_text : String = "Sample Text"
@export var speed : float
@export var delete_time : float
@export var fade_time : float
@export var y_offset : float

var tween

func _ready() -> void:
	text = popup_text
	
	$RemoveTimer.wait_time = delete_time
	$RemoveTimer.start()
	
	position.y -= y_offset

func _physics_process(_delta: float) -> void:
	position.y -= speed

func _on_remove_timer_timeout() -> void:
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property(self, "modulate", Color(255, 255, 255, 0), fade_time)
	
	await tween.finished
	queue_free()
