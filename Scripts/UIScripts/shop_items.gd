extends GridContainer

signal item_bought

func _on_item_bought():
	print("bought thing")
	item_bought.emit()


