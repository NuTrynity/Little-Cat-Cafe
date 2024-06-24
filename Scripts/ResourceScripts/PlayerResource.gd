extends Resource
class_name PlayerResource

signal meal_given()
signal meal_taken()

@export var max_meal_amt : int = 2

var meal_index : int
var carry_amt : int = 0

func give_meal(npc):
	emit_signal("meal_given", npc)

func take_meal(meal):
	if (carry_amt >= max_meal_amt):
		print("can't carry anymore")
		return
	carry_amt = carry_amt + 1
	emit_signal("meal_taken", meal)
