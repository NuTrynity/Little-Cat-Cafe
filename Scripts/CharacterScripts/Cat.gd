extends CharacterBody2D



enum State {IDLE, ACT, HUNGRY, REST }
var state = State.IDLE as State

enum IdleState {STAND, WALK }
var idleState = IdleState.STAND as State

@onready var standing_timer := Timer.new() as Timer

@onready var aiMvt := $AiMovement as CatAiMovement

var rng := RandomNumberGenerator.new() as RandomNumberGenerator

func _ready():
	add_child(standing_timer)
	standing_timer.one_shot = true
	standing_timer.connect("timeout", _on_standing_end)
	start_standing_timer()
	
	
func _physics_process(_delta : float) -> void:
	match state:
		State.IDLE:
			idle()
			pass
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
		var meep = aiMvt.target
		aiMvt.approach_target()
		if (aiMvt.reached_target()):
			idleState = IdleState.STAND
			start_standing_timer()
		
func _on_standing_end():
	idleState = IdleState.WALK
	aiMvt.target_random_point()
	

func start_standing_timer():
	standing_timer.wait_time = rng.randf_range(5.0, 10.0)
	standing_timer.start()
	
	pass
	

	
	

