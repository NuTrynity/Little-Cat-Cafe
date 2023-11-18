extends CharacterBody2D

enum State {IDLE, APPROACH, ACT, HUNGRY, REST }
var state = State.IDLE as State

enum IdleState {STAND, WALK }
var idleState = IdleState.STAND as State

@export var pause_duration : float = 4.0

@onready var standing_timer := Timer.new() as Timer
@onready var pause_timer := Timer.new() as Timer


@onready var aiMvt := $AiMovement as CatAiMovement

var rng := RandomNumberGenerator.new() as RandomNumberGenerator

var patience_timer : Timer = null

func _ready():
	add_child(standing_timer)
	standing_timer.one_shot = true
	standing_timer.connect("timeout", _on_standing_end)
	to_idle_stand()
	
	add_child(pause_timer)
	pause_timer.one_shot = true
	pause_timer.connect("timeout", _on_pause_end)
	
	
func _physics_process(_delta : float) -> void:
	print(state)
	match state:
		State.IDLE:
			idle()
			if (aiMvt.try_target_customer()):
				state = State.APPROACH
			
		State.APPROACH:
			if !aiMvt.can_target_customer():
				aiMvt.untarget_customer()
				to_idle_stand()
				return
			if aiMvt.reached_target():
				to_act()
				return
			aiMvt.approach_target()
			
		State.ACT:
			pass
			
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
	state = State.IDLE
	idleState = IdleState.STAND
	start_standing_timer()
	
func to_idle_walk():
	state = State.IDLE
	idleState = IdleState.WALK
	aiMvt.target_random_point()

func to_act():
	state = State.ACT
	var npc = aiMvt.target
	# pause timer
	start_pause_timer()
	npc.patience_timer.set_paused(true)

func start_standing_timer():
	standing_timer.wait_time = rng.randf_range(3.0, 10.0)
	standing_timer.start()
	
func start_pause_timer():
	pause_timer.wait_time = pause_duration
	pause_timer.start()

func _on_standing_end():
	to_idle_walk()
	
func _on_pause_end():
	# unpause, untarget
	aiMvt.target.patience_timer.set_paused(false)
	aiMvt.untarget_customer()
	to_idle_walk()
	
	

	
	

