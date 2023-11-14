extends Node2D

@export var speed : int = 120

# TODO: replace this line later
@onready var target = get_tree().get_root().get_node("scene_0/Table/chair/SitArea") as Node2D

@onready var npc = self.get_parent() as CharacterBody2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _ready():
	print(target.name)
	makepath()

func _physics_process(_delta: float) -> void:
	'''
	print(nav_agent.get_next_path_position())
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	print(dir)
	npc.velocity = dir * speed
	npc.move_and_slide()
	'''
	var target_position = Vector2(target.global_position.x, target.global_position.y+100)
	var distance = npc.global_position.distance_to(target_position)
	if distance > 5:
		var dir = ( target_position - npc.global_position ).normalized()
		npc.velocity = dir * speed
		npc.move_and_slide()
	
func makepath() -> void:
	'''
	nav_agent.target_position = target.position
	print(target.position)
	'''


func _on_timer_timeout():
	makepath() 
