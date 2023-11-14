extends CanvasLayer

@export var player_resources = PlayerMealCarry

@onready var input = $Control/Container/InputBlock/LineEdit
@onready var output = preload("res://Nodes/UI/pc_output_text.tscn")
@onready var output_block = $Control/Container/Texts

var line_text : String = ""

func _ready():
	input.grab_focus()

func _on_line_edit_text_submitted(new_text):
	line_text = new_text
	new_text = ""
	output_text()

func output_text():
	var line = output.instantiate()
	line.text = line_text
	output_block.add_child(line)
