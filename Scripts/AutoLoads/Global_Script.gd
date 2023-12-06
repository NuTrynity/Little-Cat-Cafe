extends Node

var cash_on_hand : int = 1000
var rating : int

var meal_types : Dictionary = {
	0: {
		"name" : "omurice",
		"price" : 50
	},
	1: {
		"name" : "cat_latte",
		"price" : 75
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
