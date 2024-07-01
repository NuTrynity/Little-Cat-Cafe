extends Node2D
class_name Door

signal npc_spawned

@export var table_manager : TableManager
@export var game_manager : GameManager
@export var player_resources : PlayerResource

@export var base_min_time : float
@export var base_max_time : float
#
@onready var npc_spawn_timer = Timer.new()
@onready var difficulty_timer = Timer.new()
@onready var randomizer = RandomNumberGenerator.new()
@onready var spawn_point = $SpawnPoint

var npc = preload("res://Nodes/CharacterNodes/npc.tscn")
var npc_spawn_time : float
var ratings_ratio : float
var day_end : bool = false

var min_time : float
var max_time : float

func _ready():
	ratings_ratio = float(GlobalScript.ratings) / float(GlobalScript.quota)
	
	min_time = base_min_time + ( (1 - ( ( (-.1)*( 1/(ratings_ratio+.1) ) ) + 1 ) ) * 10 )
	max_time = base_max_time + ( (1 - ( ( (-.1)*( 1/(ratings_ratio+.1) ) ) + 1 ) ) * 10 )
	
	print("min_time: ", min_time)
	print("max_time: ", max_time)
	
	game_manager.game_end.connect(end_day)
	
	setup_timer()
	npc_spawn_timer.start()

func end_day():
	day_end = true
	
func stop_spawning():
	var bell_sfx = load("res://Assets/SFX/shop_doorbell.mp3")
	npc_spawn_timer.stop()

func randomize_spawn():
	npc_spawn_time = randomizer.randf_range(min_time, max_time)
	print("npc_spawn_time: ", npc_spawn_time)
	npc_spawn_timer.wait_time = npc_spawn_time
	print(npc_spawn_timer.wait_time)

'''
func reduce_cooldown():
	if min_time >= 1:
		min_time -= 0.1
		max_time -= 0.1
	else:
		difficulty_timer.stop()
'''

func setup_timer():
	add_child(npc_spawn_timer)
	npc_spawn_timer.one_shot = false
	randomize_spawn()
	npc_spawn_timer.connect("timeout", _on_timer_end)
	
	'''
	add_child(difficulty_timer)
	difficulty_timer.one_shot = false
	difficulty_timer.wait_time = 2.5
	difficulty_timer.connect("timeout", reduce_cooldown)
	difficulty_timer.start()
	'''

func _on_timer_end():
	spawn_customer()
	randomize_spawn()
	
	table_manager.chair_num += 1
	
	if table_manager.chair_num > 2:
		table_manager.chair_num = 1
		table_manager.table_num += 1
		if table_manager.table_num > 4:
			table_manager.table_num = 1

func spawn_customer():
	if game_manager.check_timer_done():
		stop_spawning()
		print("timer ended")
		return
	
	var bell_sfx = load("res://Assets/SFX/shop_doorbell.mp3")
	AudioManager.play_sound(bell_sfx)
	
	if !spawn_point.get_is_empty():
		var npc = spawn_point.held_item
		if npc.state == npc.State.IDLE:
			print("waiting space occupied, customer leaving")
			return
	
	var customer = npc.instantiate()
	spawn_point.add_item(customer)
	customer.position = spawn_point.global_position
	get_parent().add_child(customer)
	
	emit_signal("npc_spawned", customer)
	
	return customer
