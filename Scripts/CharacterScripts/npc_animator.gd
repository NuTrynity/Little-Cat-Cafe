extends Node2D
class_name NpcAnimator

#@onready var start_scale : Vector2 = scale

@onready var npc = get_parent()
@onready var animations = $NPCAnimations
@onready var npc_sprite = $NPCSprite as Sprite2D
@onready var thought_bubble_meal = $ThoughtBubble/MealWanted
@onready var thought_bubble = $ThoughtBubble

func _ready():
	npc_sprite.flip_h = false
	
	thought_bubble_meal.hide()
	thought_bubble.hide()
	
func _physics_process(_delta : float) -> void:
	# check if npc is walking
	if npc.state == Npc.State.APPROACH or npc.state == Npc.State.LEAVE:
		flip_sprite_walk()

func set_meal():
	var meal = get_parent().meal_wanted
	thought_bubble_meal.texture = load(GlobalScript.meal_types[meal]["sprite_path"])

func _on_approaching():
	animations.play("walking")
	npc_sprite.texture = load("res://Sprites/customer sprites/customer1_standing.png")

func _on_ordering():
	set_meal()
	thought_bubble_meal.show()
	thought_bubble.show()
	
	animations.play("sitting")
	npc_sprite.texture = load("res://Sprites/customer sprites/customer1_sitting.png")
	
	face_table(true)
	
func _on_eating():
	face_table(true)
	thought_bubble_meal.hide()
	thought_bubble.hide()
	
func _on_leaving():
	walking()
	
	thought_bubble_meal.hide()
	thought_bubble.hide()

func face_table(towards : bool):
	var sit_area = npc.aiMvt.target as SitArea
	if towards:
		npc_sprite.flip_h = !sit_area.facing_left
	else:
		npc_sprite.flip_h = sit_area.facing_left

func _on_interacting_with_cat():
	face_table(false)
	
func _on_ready_for_cat(_npc : Npc):
	face_table(true)

func walking():
	animations.play("walking")
	npc_sprite.texture = load("res://Sprites/customer sprites/customer1_standing.png")

func flip_sprite_walk():
	if npc.velocity.x > 0:
		npc_sprite.flip_h = true
	else:
		npc_sprite.flip_h = false

