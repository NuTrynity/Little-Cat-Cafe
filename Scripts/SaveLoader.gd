extends Node

@export var player_resources : PlayerMealCarry

func save_game():
	var saved_game : SavedGame = SavedGame.new()
	
	saved_game.money = GlobalScript.cash_on_hand
	saved_game.rating = player_resources.rating
	saved_game.inventory = GlobalScript.shop
	saved_game.days = GlobalScript.days
	saved_game.items_owned = GlobalScript.items_owned
	
	ResourceSaver.save(saved_game, "user://savedata.tres")

func load_game():
	var saved_game : SavedGame = load("user://savedata.tres") as SavedGame
	
	GlobalScript.cash_on_hand = saved_game.money
	player_resources.rating = saved_game.rating
	GlobalScript.shop = saved_game.inventory
	GlobalScript.days = saved_game.days
	GlobalScript.items_owned = saved_game.items_owned
