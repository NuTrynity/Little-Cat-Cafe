extends CanvasLayer

@export var player_resources = PlayerMealCarry
@export var cheats : Array[String]

@onready var input = $Terminal/Container/InputBlock/LineEdit
@onready var output = preload("res://Nodes/UI/pc_output_text.tscn")
@onready var output_block = $Terminal/Container/OutputBlock

@onready var chef_cat = $Shop/PanelContainer/VBoxContainer/ScrollContainer/GridContainer/item1
@onready var terminal = $Shop/PanelContainer/VBoxContainer/ScrollContainer/GridContainer/item2
@onready var grey_cat = $Shop/PanelContainer/VBoxContainer/ScrollContainer/GridContainer/item3
@onready var tabby_cat = $Shop/PanelContainer/VBoxContainer/ScrollContainer/GridContainer/item4
@onready var brown_cat = $Shop/PanelContainer/VBoxContainer/ScrollContainer/GridContainer/item5
@onready var orange_cat = $Shop/PanelContainer/VBoxContainer/ScrollContainer/GridContainer/item6

@onready var cash_label = $Shop/PanelContainer/VBoxContainer/Cash

var line_text : String = ""
var click = load("res://Assets/SFX/click_sfx.ogg")

func _ready():
	input.grab_focus()
	chef_cat.item_bought.connect(_chef_bought)
	terminal.item_bought.connect(_terminal_bought)

func _process(_delta):
	cash_label.text = "Cash-on-Hand: " + str(GlobalScript.cash_on_hand) + " $"

func _terminal_bought():
	$HomeScreen/Apps/Terminal.show()

func _chef_bought():
	GlobalScript.shop[0]["buyed"] = true
	GlobalScript.shop[0]["owned"] += 1

func _on_line_edit_text_submitted(new_text):
	line_text = new_text
	input.clear()
	output_text()

func output_text():
	var line = output.instantiate()
	
	if line_text == "sudo --help":
		line.text = "Cheats:
		sudo give money - gives 9999 spendable funds
		
		exit - exits the terminal
		clear - erases the terminal"
	elif line_text == cheats[0]:
		GlobalScript.cash_on_hand += 9999
		line.text = "Cheat Activated"
	elif line_text == "exit":
		$HomeScreen.show()
		$Terminal.hide()
	elif line_text == "clear":
		var output_lines = $Terminal/Container/OutputBlock
		for otp in output_lines.get_children(): #This code block gives errors, but doesn't do much
			if otp.is_in_group("terminal_lines"):
				remove_child(otp)
				otp.remove_from_group("terminal_lines")
				otp.queue_free()
	else:
		line.text = "Invalid Input see 'sudo --help'"
	
	output_block.add_child(line)

func _on_terminal_btn_pressed():
	$HomeScreen.hide()
	$Terminal.show()
	input.grab_focus()
	AudioManager.play_sound(click)

func _on_exit_btn_pressed():
	$Shop.hide()
	$HomeScreen.show()
	AudioManager.play_sound(click)

func _on_shop_btn_pressed():
	$Shop.show()
	$HomeScreen.hide()
	AudioManager.play_sound(click)

func _on_power_btn_pressed():
	hide()
	get_tree().paused = false
	AudioManager.play_sound(click)
