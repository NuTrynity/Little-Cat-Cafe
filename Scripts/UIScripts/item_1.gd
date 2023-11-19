extends VBoxContainer
class_name ShopItem

signal item_bought

@export var image : CompressedTexture2D
@export var item_name : String
@export var item_price : float
@export var buy_once : bool
@export var buy_amt : int

@onready var image_rect = $img
@onready var item_label = $label
@onready var price_label = $price
@onready var btn = $btn

@onready var leave_area = get_tree().get_nodes_in_group("LeaveArea")[0] as Node2D

func _ready():
	setup_item()

func setup_item():
	image_rect.texture = image
	item_label.text = item_name
	price_label.text = str(item_price) + " $"

func _on_btn_pressed():
	buy_item()

func enough_money() -> bool:
	return GlobalScript.cash_on_hand >= item_price
	
func buy_item():
	if enough_money():
		GlobalScript.cash_on_hand -= item_price
		item_bought.emit()
		
		if buy_once == true:
			btn.text = "Sold Out"
			btn.disabled = true
		print('item bought')
		
func spawn_cat(cat_node):
	var cat_instance = cat_node.instantiate() as Node2D
	get_tree().get_root().get_node("scene_0").add_child(cat_instance)
	cat_instance.global_position = leave_area.global_position
