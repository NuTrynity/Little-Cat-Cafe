extends ProgressBar
@export var game_manager : GameManager

@onready var label = $Label
@onready var animation = $Animation
@onready var combo_timer = Timer.new()

var can_play_anim : bool = true

func _ready():
	value = max_value
	game_manager.start_combo.connect(combo_start)
	
	add_child(combo_timer)
	combo_timer.one_shot = false
	combo_timer.wait_time = 1
	combo_timer.connect("timeout", on_timeout)

func _process(_delta):
	label.text = "Combo: " + str(game_manager.combo_meter)

func combo_start():
	value = max_value
	combo_timer.start()
	
	if can_play_anim == true:
		animation.play("show_combo")
		can_play_anim = false
	

func on_timeout():
	value -= 1
	
	if value < 0:
		combo_timer.stop()
		can_play_anim = true
		animation.play_backwards("show_combo")
		
		await animation.animation_finished
		value = max_value
		game_manager.combo_meter = 1
