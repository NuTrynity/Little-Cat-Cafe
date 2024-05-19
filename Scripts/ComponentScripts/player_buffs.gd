extends Node

@export var player_stats : PlayerStats
@export var game_manager : GameManager

func _ready():
	game_manager.connect("start_combo", _on_combo_increase)
	game_manager.connect("combo_finished", _on_combo_finish)
	
	player_stats.set_speed(500.0)

func _on_combo_increase():
	player_stats.set_speed(player_stats.get_speed() + 25.0)

func _on_combo_finish():
	player_stats.set_speed(500.0)
