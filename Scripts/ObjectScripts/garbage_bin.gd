extends Node2D

@onready var interact_area = $InteractionArea


# Called when the node enters the scene tree for the first time.
func _ready():
	interact_area.interact = Callable(self, "_toss_item")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
