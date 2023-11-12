extends Resource

class_name PlayerMealCarry

signal meal_given()

@export var max_carry_amt : int = 1

var carry_amt : int = 0

func give_meal():
	meal_given.emit()
	carry_amt -= 1
