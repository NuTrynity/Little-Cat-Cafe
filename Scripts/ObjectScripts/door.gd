extends Node2D

@export var table_manager : TableManager

@onready var npc_spawn_timer = Timer.new()
@onready var randomizer = RandomNumberGenerator.new()

var npc = preload("res://Nodes/CharacterNodes/npc.tscn")
var npc_spawn_time : float

func _ready():
	setup_timer()
	npc_spawn_timer.start()

func randomize_spawn():
	npc_spawn_time = randomizer.randf_range(3, 10)
	npc_spawn_timer.wait_time = npc_spawn_time

func setup_timer():
	add_child(npc_spawn_timer)
	npc_spawn_timer.one_shot = false
	randomize_spawn()
	npc_spawn_timer.connect("timeout", _on_timer_end)

func _on_timer_end():
	spawn_customer()
	randomize_spawn()
	
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
