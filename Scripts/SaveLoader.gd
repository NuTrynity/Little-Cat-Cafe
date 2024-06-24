extends Node
@export var player_resources : PlayerResource

func save_game():
	var saved_game : SavedGame = SavedGame.new()
	
	saved_game.money = GlobalScript.money
	saved_game.rating = GlobalScript.ratings
	saved_game.inventory = GlobalScript.shop
	saved_game.days = GlobalScript.days
	saved_game.items_owned = GlobalScript.items_owned
	
	ResourceSaver.save(saved_game, "user://savedata.tres")

func load_game():
	var saved_game : SavedGame = load("user://savedata.tres") as SavedGame
	
	GlobalScript.money = saved_game.money
	GlobalScript.ratings = saved_game.rating
	GlobalScript.shop = saved_game.inventory
	GlobalScript.days = saved_game.days
	GlobalScript.items_owned = saved_game.items_owned
