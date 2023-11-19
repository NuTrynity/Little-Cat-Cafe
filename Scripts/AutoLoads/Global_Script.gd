extends Node

var cash_on_hand : float

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
		"owned" : 0,
		"buyed" : false
	},
	1 : {
		"name" : "grey_cat",
		"owned" : 5,
		"buyed" : false
	},
	2 : {
		"name" : "tabby_cat",
		"owned" : 0,
		"buyed" : false
	},
	3 : {
		"name" : "brown_cat",
		"owned" : 0,
		"buyed" : false
	},
	4 : {
		"name" : "orange_cat",
		"owned" : 0,
		"buyed" : false
	},
}
