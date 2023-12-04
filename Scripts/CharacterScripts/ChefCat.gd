extends Cat
class_name ChefCat

var target_point : Node2D = null
var targeted_device : Node2D = null

func _ready():
	setup_cat()
	
func _physics_process(_delta : float) -> void:
	match state:
		State.IDLE:
			idle()
			if (!on_cd):
				if (chef_try_target()):
					to_approach()
					
		State.APPROACH:
			if (!targeted_device.is_cooking):
				untarget_device()
				to_idle_stand()
				start_sleep_timer()
			elif aiMvt.reached_target():
				chef_to_act()
			else:
				walking()
				
		State.ACT:
			if !targeted_device.is_cooking:
				chef_stop_act()
			else:
				targeted_device.increase_progress()


func chef_try_target() -> bool:
	var cooking_devices = get_tree().get_nodes_in_group("cooking")
	
	for device in cooking_devices:
		if (device.is_cooking && device.targeted == null):
			target_device(device)
			return true
			
	return false

func target_device(device: Node2D):
	device.targeted = self
	targeted_device = device
	target_point = device.get_node("TargetPoint")
	aiMvt.target = target_point
	aiMvt.makepath()

func untarget_device():
	targeted_device.targeted = null
	targeted_device = null
	target_point = null
	aiMvt.target = null

func chef_to_act():
	state = State.ACT
	
	animations.interact()
	
func chef_stop_act():
	untarget_device()
	to_idle_walk()
	start_cd_timer()
	start_sleep_timer()
	
func _on_cd_end():
	on_cd = false
	
