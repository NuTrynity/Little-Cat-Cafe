extends Label
class_name PopUp_Label

var speed : float
var delete_time : float
var fade_time : float
var y_offset : float

func _ready() -> void:
	$RemoveTimer.wait_time = delete_time
	$RemoveTimer.start()
	
	position.x -= size.x / 2
	position.y -= y_offset

func _physics_process(_delta: float) -> void:
	position.y -= speed

func _on_remove_timer_timeout() -> void:
	var tween
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property(self, "modulate", Color(255, 255, 255, 0), fade_time)
	
	await tween.finished
	queue_free()

func create_popup_label(new_text : String, new_speed : float, new_pos, new_delete_time : float, new_fade_time : float, new_y_offset, parent):
	var popUp = preload("res://Nodes/UINodes/PopUp.tscn")
	var new_popUp = popUp.instantiate()
	
	new_popUp.text = new_text
	new_popUp.speed = new_speed
	new_popUp.position = new_pos
	new_popUp.delete_time = new_delete_time
	new_popUp.fade_time = new_fade_time
	new_popUp.y_offset = new_y_offset
	
	parent.add_child.call_deferred(new_popUp)
