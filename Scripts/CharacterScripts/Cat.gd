extends CharacterBody2D

@onready var nav_mesh : NavigationRegion2D = get_tree().get_root().get_node("scene_0/NavigationRegion2D")

enum State {IDLE, ACT, HUNGRY, REST }

func _ready():
	pass
	
func _physics_process(_delta : float) -> void:
	pass

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
	
	
