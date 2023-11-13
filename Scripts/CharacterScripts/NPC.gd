extends CharacterBody2D

@export var table : Node2D
@export var player_resources : PlayerMealCarry
@export var move_speed : float = 300.0

@onready var npc_sprite = $NPCSprite
@onready var interact_area = $InteractionArea
@onready var patience_bar = $Patience
@onready var patience_timer = Timer.new()

var patience : float
var satisfied : bool = false
var angry : bool = false
var already_interacted : bool = false

func _ready():
	interact_area.interact = Callable(self, "_on_player_give_meal")
	patience = 100
	patience_bar.global_position.y -= 148
	
	patience_timer_setup()

func _physics_process(_delta : float) -> void:
	#NPC Movement //TODO MAKE NPC NAVIGATION SYSTEM <https://youtu.be/aW4Oa-4dyXA>
	if satisfied == true:
		velocity.y = -move_speed
		move_and_slide()
	
	patience_bar.value = patience
	
	#NPC State Block
	var is_sitting : bool = false
	
	if is_sitting == true:
		npc_sprite.texture = load("res://Sprites/customer sprites/customer1_sitting.png")
	else:
		npc_sprite.texture = load("res://Sprites/customer sprites/customer1_standing.png")

func patience_timer_setup():
	add_child(patience_timer)
	patience_timer.one_shot = false
	patience_timer.wait_time = 0.1
	patience_timer.connect("timeout", _on_timer_timeout)
	patience_timer.start()

func _on_timer_timeout():
	patience -= 1
	
	if patience_bar.value <= 0:
		angry = true
		patience_timer.stop()
		print("aw you made the customer mad! :(")

func _on_player_give_meal():
	if player_resources.carry_amt > 0 && angry == false && already_interacted == false:
		player_resources.give_meal()
		patience_timer.stop()
		patience_bar.hide()
		satisfied = true
		already_interacted = true
		print("Thank you for the food sister, I'm going now")
	
	print(player_resources.carry_amt)
