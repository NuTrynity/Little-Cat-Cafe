extends AiMovement
class_name CatAiMovement

@export var cat_speed : int = 80

@onready var nav_mesh : NavigationRegion2D = get_tree().get_root().get_node("scene_0/NavigationRegion2D")

var target_point : Node2D

var targeted_list = []
var target_npc : Node2D = null

func _ready():
	setup_cat_aimvt()
	
func setup_cat_aimvt():
	speed = cat_speed
	
	target_point = Node2D.new()
	add_child(target_point)
	
	target = target_point
	
func _on_timer_timeout():
	pass

# called in process
func try_target_customer() -> bool:
	var customers = get_tree().get_nodes_in_group("customers")
	
	for npc in customers:
		if (npc.targeter == null) && (npc.state == npc.State.ORDER && !targeted_list.has(npc)):
			target_customer(npc)
			return true
			
	return false
	
func target_customer(npc:Npc):
	npc.targeter = self
	target_npc = npc
	target = npc.get_cat_point()
	makepath()

func can_target_customer() -> bool:
	return target_npc.patience_bar.is_visible()

func untarget_customer():
	targeted_list.append(target_npc as Node2D)
	target_npc.targeter = null
	target = null
	target_npc = null

func target_random_point():
	target_point.global_position = choose_random_point()
	target = target_point
	makepath()

func choose_random_point() -> Vector2:
	var rng = RandomNumberGenerator.new()
	var random_idx = rng.randi_range(0, nav_mesh.navigation_polygon.get_polygon_count()-1)
	
	var polygon_idx = nav_mesh.navigation_polygon.get_polygon(random_idx) as PackedInt32Array
	var all_vertices = nav_mesh.navigation_polygon.get_vertices()
	
	var polygon_array : PackedVector2Array = []
	for vertex in polygon_idx:
		polygon_array.append(all_vertices[vertex])
	
	var randomPoint = PolygonRandomPointGenerator.new(polygon_array)
	
	return randomPoint.get_random_point()
