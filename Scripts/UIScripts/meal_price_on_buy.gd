extends Label
@export var price : String
@onready var delete_timer = Timer.new()

func _ready():
	text = "+ " + price + "$"
	
	add_child(delete_timer)
	delete_timer.wait_time = 1
	delete_timer.one_shot = true
	delete_timer.connect("timeout", on_delete_timeout)
	delete_timer.start()

func _process(_delta):
	position.y -= 4

func on_delete_timeout():
	queue_free()
