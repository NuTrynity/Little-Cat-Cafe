extends CharacterBody2D
class_name Npc

signal approaching
signal leaving
signal ordering
signal eating
signal angry

signal interacting_with_cat
signal ready_for_cat

@export var game_manager : GameManager
@export var player_resources : PlayerResource

@export var patience : float
@export var ratings_bonus_max : int = 25
@export var ratings_increase_amt : int = 50
@export var ratings_decrease_amt : int = 150

@onready var interact_area = $InteractionArea
@onready var patience_bar = $Patience
@onready var patience_timer = Timer.new()
@onready var eat_timer = Timer.new()
@onready var aiMvt := $AiMovement as NpcAiMovement
@onready var meal_price_label = preload("res://Nodes/UI/meal_price_on_buy.tscn")

var meal_wanted : int
var can_be_interacted : bool = false
var is_leaving : bool = false
var is_sitting : bool = false
var is_angry : bool = false

# for cat targeting
var targeter : Node2D = null

var current_meal : Node2D = null

enum State {APPROACH, IDLE, ORDER, EAT, LEAVE}
var state := State.IDLE as State

func _ready():
	patience_bar.max_value = patience
	patience_bar.global_position.y -= 64
	patience_bar.hide()
	
	interact_area.interact = Callable(self, "_on_player_give_meal")
	interact_area.monitoring = false
	
	meal_wanted = random_meal()

func random_meal():
	var rand = RandomNumberGenerator.new()
	var meal_index = rand.randi_range(0, GlobalScript.meal_types.size()-1)
	return meal_index

func _physics_process(_delta : float) -> void:
	match state:
		# idle: deciding what to do
		State.IDLE:
			var find_target = aiMvt.find_and_pick_target()
			if find_target != null:
				idle_to_approach()
			
		# approaching: going towards target
		State.APPROACH:
			aiMvt.approach_target()
			
			if aiMvt.reached_target():
				approach_to_order()
			
		# ordering: sitting at the table waiting for food
		State.ORDER:
			# switches to EAT after grab_meal() is called, or LEAVE when the patience timer runs out
			return
		
		# eating: waits for eating timer to finish, then switches to LEAVE
		State.EAT:
			return
			
		# leaving: npc approaches door
		State.LEAVE:
			aiMvt.approach_target()

func idle_to_approach():
	approaching.emit()
	
	aiMvt.makepath()
	state = State.APPROACH

func approach_to_order():
	ordering.emit()
	
	state = State.ORDER
	patience_timer_setup()
	patience_bar.value = patience
	patience_timer.start()
	patience_bar.show()
	interact_area.monitoring = true
	
	ready_for_cat_func()
	
func to_leave():
	leaving.emit()
	
	state = State.LEAVE
	aiMvt.goto_exit()
	patience_bar.hide()
	interact_area.monitoring = false

# ends sit_area action
func _on_meal_finished():
	current_meal.queue_free()
	current_meal = null
	to_leave()
	
func _on_timer_timeout():
	patience -= 1
	patience_bar.value = patience
	
	# out of patience, gets angry and leaves
	if patience_bar.value <= 0:
		patience_timer.stop()
		to_leave()
		
		GlobalScript.adjust_ratings(-ratings_decrease_amt)
	
func patience_timer_setup():
	add_child(patience_timer)
	patience_timer.one_shot = false
	patience_timer.wait_time = 0.1
	patience_timer.connect("timeout", _on_timer_timeout)
	
	add_child(eat_timer)
	eat_timer.one_shot = true
	eat_timer.wait_time = 5
	eat_timer.connect("timeout", _on_meal_finished)

func _on_player_give_meal():
	player_resources.give_meal(self)

# called when player gives correct meal to npc
func grab_meal(meal):
	var sit_area = aiMvt.target as SitArea
	player_resources.carry_amt -= 1
	meal.get_parent().remove_child(meal)
	add_child(meal)
	meal.global_position = self.global_position
	meal.position.y -= 143
	current_meal = meal
	if sit_area.facing_left:
		meal.position.x -= 150
	else:
		meal.position.x += 150
	order_to_eat()
	
func order_to_eat():
	eating.emit()
	
	state = State.EAT
	patience_timer.stop()
	patience_bar.hide()
	eat_timer.start()
	game_manager.start_combo.emit()
	interact_area.monitoring = false
	
	add_score()
	spawn_label()
	
func add_score():
	GlobalScript.inventory[meal_wanted]["count"] -= 1
	GlobalScript.money += GlobalScript.meal_types[meal_wanted]["price"] * game_manager.combo_meter
	
	var ratings_amt = ratings_increase_amt + (patience_bar.ratio * ratings_bonus_max)
	GlobalScript.adjust_ratings(ratings_amt)
	game_manager.combo_meter += 1

func spawn_label():
	var price_label = meal_price_label.instantiate()
	price_label.price = str(GlobalScript.meal_types[meal_wanted]["price"] * game_manager.combo_meter)
	get_parent().add_child(price_label)
	price_label.position = global_position
	price_label.position.y -= 360 #just on her head
	price_label.position.x -= price_label.size.x / 2

func _on_leave_detector_area_entered(area):
	if area.is_in_group("LeaveArea"):
		if state == State.LEAVE:
			game_manager.check_result()
			queue_free()

# returns point where cat should sit nearby, don't call when leaving
func get_cat_point() -> Node2D:
	var sit_area = aiMvt.target as SitArea
	return sit_area.get_cat_point()

func interacting_with_cat_func():
	interacting_with_cat.emit()

func ready_for_cat_func():
	if (state == State.ORDER && patience_bar.is_visible()):
		emit_signal("ready_for_cat", self)
