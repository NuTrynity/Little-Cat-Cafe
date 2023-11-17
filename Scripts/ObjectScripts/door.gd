extends Node2D

@export var table_manager : TableManager
@export var npc_spawn_time : int

@onready var npc_spawn_timer = Timer.new()

var npc = preload("res://Nodes/CharacterNodes/npc.tscn")

func _ready():
	setup_timer()
	npc_spawn_timer.start()

func setup_timer():
	add_child(npc_spawn_timer)
	npc_spawn_timer.one_shot = false
	npc_spawn_timer.wait_time = npc_spawn_time
	npc_spawn_timer.connect("timeout", _on_timer_end)

func _on_timer_end():
	spawn_customer()
	
	table_manager.chair_num += 1
	
	if table_manager.chair_num > 2:
		table_manager.chair_num = 1
		table_manager.table_num += 1
		if table_manager.table_num > 4:
#			npc_spawn_timer.stop()
			table_manager.table_num = 1

func spawn_customer():
	var customer = npc.instantiate()
	customer.position = global_position
	customer.position.y += 100
	get_parent().add_child(customer)
