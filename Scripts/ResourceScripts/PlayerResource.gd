extends Resource

class_name PlayerMealCarry

signal meal_given()

@export var max_carry_amt : int = 1

var money : float = 0
var ratings : int = 5
var carry_amt : int = 0

func give_meal():
	meal_given.emit()
