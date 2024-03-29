extends Door

func _ready():
	await get_tree().process_frame
	game_manager.customers = 2
