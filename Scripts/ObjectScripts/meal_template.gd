extends Node2D

var player_position = null

func _on_pick_up_area_body_entered(body):
	if body.has_method("take_meal"):
		player_position = body.global_position
