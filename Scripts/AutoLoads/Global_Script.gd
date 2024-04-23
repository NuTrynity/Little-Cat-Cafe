extends Node

var sfx_volume : float = 1
var music_volume : float = 1

var ratings : int = 0
var quota : int = 7500

var money : int = 1000
var days : int = 0

func adjust_ratings(amt : int):
	var result = ratings + amt
	if result < 0:
		result = 0
	ratings = result

var meal_types : Dictionary = {
	0: {
		"name" : "omurice",
		"price" : 50,
		"sprite_path" : "res://Sprites/omurice.png"
	},
	1: {
		"name" : "cat_latte",
		"price" : 75,
		"sprite_path" : "res://Sprites/cat_latte.png"
	},
}

var inventory : Dictionary = {
	0: {
		"name" : "omurice",
		"price" : 50,
		"count" : 0
	},
	1: {
		"name" : "cat_latte",
		"price" : 75,
		"count" : 0
	},
}

var shop : Dictionary = {
	0 : {
		"name" : "chef_cat",
		"price" : 1000,
		"owned" : 0,
		"buyed" : false,
		"node" : "res://Nodes/CharacterNodes/chef_cat.tscn"
	},
	1 : {
		"name" : "grey_cat",
		"price" : 100,
		"owned" : 0,
		"node" : "res://Nodes/CharacterNodes/grey_cat.tscn"
	},
	2 : {
		"name" : "tabby_cat",
		"price" : 200,
		"owned" : 0,
		"node" : "res://Nodes/CharacterNodes/tabby_cat.tscn"
	},
	3 : {
		"name" : "brown_cat",
		"price" : 300,
		"owned" : 0,
		"node" : "res://Nodes/CharacterNodes/brown_cat.tscn"
	},
	4 : {
		"name" : "orange_cat",
		"price" : 500,
		"owned" : 0,
		"node" : "res://Nodes/CharacterNodes/orange_cat.tscn"
	},
}

var items_owned : Dictionary = {
	"table" : {
		"owned" : 2,
		"positions" : [Vector2(1650,892), Vector2(1438,1251), Vector2(778, 896), Vector2(544, 1249)],
		"node" : "res://Nodes/ObjectNodes/table.tscn",
		"parent_name" : "scene_0"
	},
	"frypan" : {
		"owned" : 1,
		"positions" : [Vector2(-171,-140), Vector2(10,-138)],
		"node" : "res://Nodes/ObjectNodes/fryPan.tscn",
		"parent_name" : "scene_0/KitchenCounter2"
	},
	"coffee machine" : {
		"owned" : 1,
		"positions" : [Vector2(-207.22,-121.65), Vector2(-17.526,-121.65)],
		"node" : "res://Nodes/ObjectNodes/coffee_machine.tscn",
		"parent_name" : "scene_0/KitchenCounter"
	}
}

