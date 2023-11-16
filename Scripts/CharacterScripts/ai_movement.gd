extends Node2D

@export var table_manager : TableManager
@export var speed : int = 150

# TODO: replace this line later
@onready var target = get_tree().get_root().get_node("scene_0/Table" + str(table_manager.table_num) +  "/chair" + str(table_manager.chair_num) + "/SitArea") as Node2D
@onready var door = get_tree().get_root().get_node("scene_0/Door")

@onready var npc = self.get_parent() as CharacterBody2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _ready():
	npc.leaving.connect(goto_exit)
	makepath()

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	npc.velocity = dir * speed
	npc.move_and_slide()
	
#	var target_position = Vector2(target.global_position.x, target.global_position.y+100)
#	var distance = npc.global_position.distance_to(target_position)
#	if distance > 5:
#		var dir = ( target_position - npc.global_position ).normalized()
#		npc.velocity = dir * speed
#		npc.move_and_slide()
	
func makepath() -> void:
	nav_agent.target_position = target.global_position

func goto_exit():
	target = door
	makepath()

func _on_timer_timeout():
	pass
#	makepath() 
