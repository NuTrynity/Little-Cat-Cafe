extends CanvasLayer

signal use_move_vector

@onready var touch_pad = $TouchScreenButton
@onready var inner_circle = $InnerCircle

var move_vector = Vector2(0, 0)
var joystick_active : bool = false

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if touch_pad.is_pressed():
			move_vector = calc_move_vector(event.position)
			inner_circle.position = event.position
			limit_inner_circle(event.position)
			joystick_active = true
	
	if event is InputEventScreenTouch:
		if event.pressed == false:
			inner_circle.hide()
			joystick_active = false

func _physics_process(_delta):
	if joystick_active:
		emit_signal("use_move_vector", move_vector)

func limit_inner_circle(event_position):
	var tex_center = touch_pad.position + Vector2(192, 192)
	var limit = 192
	
	if tex_center.distance_to(event_position) > limit:
		var limit_vector = move_vector * limit
		inner_circle.position = tex_center + limit_vector
	else:
		inner_circle.position = event_position
	
	inner_circle.show()

func calc_move_vector(event_position):
	var tex_center = touch_pad.position + Vector2(192, 192) #touch_pad.size.(axis) / 2
	return (event_position - tex_center).normalized()
