extends Node2D
class_name SitArea

@export var facing_left : bool

# chair vars
var targeted : bool = false
var npc : Node2D = null


func set_targeted(npc: Node2D):
	npc = npc
	targeted = true
	
func set_untargeted():
	npc = null
	targeted = false

func is_targeted() -> bool:
	return targeted
	
# called once when going from IDLE to ACT
func npc_act_setup(npc):
	set_targeted(npc)
	npc.sit_area_act_setup()
	
# call in process
func npc_act(npc):
	npc.sit_area_act()
	
func npc_leave(npc):
	set_untargeted()
	npc.set_leave_state()
	npc.sit_area_leave()
