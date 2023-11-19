extends VBoxContainer
signal item_bought

@export var image : CompressedTexture2D
@export var item_name : String
@export var item_price : float
@export var buy_once : bool

@onready var image_rect = $img
@onready var item_label = $label
@onready var price_label = $price
@onready var btn = $btn

func _ready():
	image_rect.texture = image
	item_label.text = item_name
	price_label.text = str(item_price) + " $"

func _on_btn_pressed():
	if GlobalScript.cash_on_hand >= item_price:
		GlobalScript.cash_on_hand -= item_price
		item_bought.emit()
		
		if buy_once == true:
			btn.text = "Sold Out"
			btn.disabled = true
		print('item bought')
