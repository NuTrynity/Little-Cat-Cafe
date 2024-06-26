extends ShopItem

func _ready():
	setup_item()
	
func _on_btn_pressed():
	if enough_money():
		buy_item()
