extends CharacterBody2D

enum State {IDLE, APPROACH, ACT, HUNGRY, REST }
var state = State.IDLE as State

enum IdleState {STAND, WALK}
var idleState = IdleState.STAND as State

@export var pause_duration : float = 4.0

@export var idle_speed : int = 70
@export var approach_speed : int = 110
@export var cd_duration : float = 4.0
@export var rating_value : int = 5

@onready var standing_timer := Timer.new() as Timer
@onready var pause_timer := Timer.new() as Timer
@onready var cd_timer := Timer.new() as Timer

@onready var aiMvt := $AiMovement as CatAiMovement

var rng := RandomNumberGenerator.new() as RandomNumberGenerator

var patience_timer : Timer = null
var on_cd : bool = false

func _ready():
	add_child(standing_timer)
	standing_timer.one_shot = true
	standing_timer.connect("timeout", _on_standing_end)
	to_idle_stand()
	
	add_child(pause_timer)
	pause_timer.one_shot = true
	pause_timer.connect("timeout", _on_pause_end)
	
	add_child(cd_timer)
	cd_timer.one_shot = true
	cd_timer.connect("timeout", _on_cd_end)
	
func _physics_process(_delta : float) -> void:
	match state:
		State.IDLE:
			idle()
			if (!on_cd):
				if (aiMvt.try_target_customer()):
					to_approach()
			
		State.APPROACH:
			if !aiMvt.can_target_customer():
				aiMvt.untarget_customer()
				to_idle_stand()
			elif aiMvt.reached_target():
				to_act()
			else:
				aiMvt.approach_target()
			
		State.ACT:
			if !aiMvt.can_target_customer():
				aiMvt.untarget_customer()
				to_idle_walk()
				pause_timer.stop()
				start_cd_timer()
			
		State.HUNGRY:
			pass
		State.REST:
			pass

# called in process
func idle():
	# timer of random length for how long to idle
	if (idleState == IdleState.STAND):
		return
	# set a random target and walk towards it
	if (idleState == IdleState.WALK):
		aiMvt.approach_target()
		if (aiMvt.reached_target()):
			to_idle_stand()
		
func to_idle_stand():
	aiMvt.speed = idle_speed
	state = State.IDLE
	idleState = IdleState.STAND
	start_standing_timer()
	
func to_idle_walk():
	aiMvt.speed = idle_speed
	state = State.IDLE
	idleState = IdleState.WALK
	aiMvt.target_random_point()

func to_approach():
	state = State.APPROACH
	aiMvt.speed = approach_speed

func to_act():
	state = State.ACT
	var npc = aiMvt.target
	# pause timer
	start_pause_timer()
	npc.patience_timer.set_paused(true)

func start_standing_timer():
	standing_timer.wait_time = rng.randf_range(2.0, 10.0)
	standing_timer.start()
	
func start_pause_timer():
	pause_timer.wait_time = pause_duration
	pause_timer.start()
	
func start_cd_timer():
	on_cd = true
	cd_timer.wait_time = cd_duration
	cd_timer.start()

func _on_standing_end():
	to_idle_walk()
	
func _on_pause_end():
	# unpause, untarget
	aiMvt.target.patience_timer.set_paused(false)
	aiMvt.untarget_customer()
	to_idle_walk()
	start_cd_timer()
	
func _on_cd_end():
	on_cd = false
	
	

	
	

