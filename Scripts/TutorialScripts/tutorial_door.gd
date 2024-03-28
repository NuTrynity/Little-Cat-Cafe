extends Door

func _ready():
	await get_tree().process_frame
	customer_amt = 1
