extends VBoxContainer
class_name ShopItem

signal item_bought

@export var image : CompressedTexture2D
@export var item_name : String
@export var item_price : float
@export var buy_once : bool
var buy_amt : int = 0

@onready var image_rect = $img
@onready var item_label = $label
@onready var price_label = $price
@onready var btn = $btn

@onready var leave_area = get_tree().get_nodes_in_group("LeaveArea")[0] as Node2D

var click = load("res://Assets/SFX/click_sfx.ogg")

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
		buy_amt += 1
		GlobalScript.cash_on_hand -= item_price
		item_bought.emit()
		AudioManager.play_sound(click)
		
		if buy_amt == get_max_amt():
			btn.text = "Sold Out"
			btn.disabled = true

# override this in inherited classes
func get_max_amt() -> int:
	return 2
