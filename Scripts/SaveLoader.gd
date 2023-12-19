extends Node

func save_game():
	var saved_game : SavedGame = SavedGame.new()
	
	saved_game.money = GlobalScript.cash_on_hand
	saved_game.rating = GlobalScript.rating
	saved_game.inventory = GlobalScript.shop
	saved_game.days = GlobalScript.days
	
	ResourceSaver.save(saved_game, "user://savedata.tres")

func load_game():
	var saved_game : SavedGame = load("user://savedata.tres") as SavedGame
	
	GlobalScript.cash_on_hand = saved_game.money
	GlobalScript.rating = saved_game.rating
	GlobalScript.shop = saved_game.inventory
	GlobalScript.days = saved_game.days
