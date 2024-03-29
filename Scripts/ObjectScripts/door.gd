extends Node2D
class_name Door

signal npc_spawned

@export var table_manager : TableManager
@export var game_manager : GameManager
@export var player_resources : PlayerMealCarry

@export var base_min_time : float
@export var base_max_time : float
#
@onready var npc_spawn_timer = Timer.new()
@onready var difficulty_timer = Timer.new()
@onready var randomizer = RandomNumberGenerator.new()

var npc = preload("res://Nodes/CharacterNodes/npc.tscn")
var npc_spawn_time : float
var ratings_ratio : float
var day_end : bool = false

var customer_amt : int
var min_time : float
var max_time : float

func _ready():
	ratings_ratio = float(player_resources.rating) / float(player_resources.quota)
	
	# 40 is additional customers based on rating
	customer_amt = 4 + round(ratings_ratio * 30)
	game_manager.customers = customer_amt
	game_manager.customers = game_manager.customers
	print("game_manager.customers: ", game_manager.customers)
	
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
	AudioManager.play_sound(bell_sfx)

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
	if customer_amt <= 0:
		stop_spawning()
		print("no more customers!!!")
		return
	
	var bell_sfx = load("res://Assets/SFX/shop_doorbell.mp3")
	var customer = npc.instantiate()
	customer.position = global_position
	customer.position.y += 100
	get_parent().add_child(customer)
	
	customer_amt -= 1
	emit_signal("npc_spawned", customer)
	AudioManager.play_sound(bell_sfx)
	
	return customer
