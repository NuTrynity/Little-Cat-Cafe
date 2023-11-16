extends Resource

class_name PlayerMealCarry

signal meal_given()
signal meal_taken()

@export var max_amt : int = 2

var meal_carried : Array
var money : float = 0
var ratings : int = 0
var carry_amt : int = 0

func give_meal(npc):
	meal_given.emit(npc)
#	emit_signal("meal_given", npc)

func take_meal(meal):
	if (carry_amt >= max_amt):
		print("can't carry anymore")
		return
	carry_amt = carry_amt + 1
	meal_taken.emit(meal)
#	emit_signal("meal_taken", meal)
