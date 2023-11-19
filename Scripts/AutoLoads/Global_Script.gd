extends Node

var cash_on_hand : float = 5000

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
		"buyed" : false
	},
	1 : {
		"name" : "grey_cat",
		"price" : 100,
		"owned" : 0
	},
	2 : {
		"name" : "tabby_cat",
		"price" : 200,
		"owned" : 0
	},
	3 : {
		"name" : "brown_cat",
		"price" : 300,
		"owned" : 0
	},
	4 : {
		"name" : "orange_cat",
		"price" : 500,
		"owned" : 0
	},
}
