extends CharacterBody2D

signal leaving

@export var player_resources : PlayerMealCarry
@export var move_speed : float = 300.0

@onready var animations = $NPCAnimations
@onready var npc_sprite = $NPCSprite
@onready var interact_area = $InteractionArea
@onready var patience_bar = $Patience
@onready var meal_want = $MealWanted
@onready var patience_timer = Timer.new()
@onready var eat_timer = Timer.new()

var patience : float
var can_be_interacted : bool = false
var is_leaving : bool = false
var is_sitting : bool = false

func _ready():
	interact_area.interact = Callable(self, "_on_player_give_meal")
	patience = 100
	patience_bar.global_position.y -= 64
	
	patience_timer_setup()

func _physics_process(_delta : float) -> void:
	patience_bar.value = patience
	
	#NPC State Block
	if is_sitting == true && not is_leaving:
		animations.play("sitting")
		meal_want.show()
		patience_bar.show()
		npc_sprite.texture = load("res://Sprites/customer sprites/customer1_sitting.png")
	else:
		animations.play("walking")
		meal_want.hide()
		patience_bar.hide()
		npc_sprite.texture = load("res://Sprites/customer sprites/customer1_standing.png")

func patience_timer_setup():
	add_child(patience_timer)
	patience_timer.one_shot = false
	patience_timer.wait_time = 0.1
	patience_timer.connect("timeout", _on_timer_timeout)
	
	add_child(eat_timer)
	eat_timer.one_shot = true
	eat_timer.wait_time = 3
	eat_timer.connect("timeout", on_meal_finished)

func _on_timer_timeout():
	patience -= 1
	
	if patience_bar.value <= 0:
		patience_timer.stop()
		leaving.emit()
		is_leaving = true

func _on_player_give_meal():
	if player_resources.carry_amt > 0 && can_be_interacted == true:
		player_resources.give_meal()
		patience_timer.stop()
		patience_bar.hide()
		eat_timer.start()
		is_leaving = true
		can_be_interacted = false
		print("Thank you for the food sister, I'm going now")

func on_meal_finished():
	leaving.emit()

func _on_chair_detector_area_entered(area):
	if area.is_in_group("chair"):
		is_sitting = true
		can_be_interacted = true
		patience_timer.start()

func _on_chair_detector_area_exited(area):
	if area.is_in_group("chair"):
		is_sitting = false
		can_be_interacted = false
		patience_timer.stop()

func _on_leave_detector_area_entered(area):
	if area.is_in_group("LeaveArea"):
		if is_leaving:
			queue_free()
			print("customer has left")
