extends Resource

class_name PlayerMealCarry

signal meal_given()
signal meal_taken()

@export var max_amt : int = 2

var meal_index : int
var money : float = 0
var ratings : int = 0
var carry_amt : int = 0

func randomize_meal_index():
	var randomizer = RandomNumberGenerator.new()
	meal_index = randomizer.randi_range(0, 1)
	return meal_index

func give_meal(npc):
	emit_signal("meal_given", npc)

func take_meal(meal):
	if (carry_amt >= max_amt):
		print("can't carry anymore")
		return
	carry_amt = carry_amt + 1
	emit_signal("meal_taken", meal)
	for i in GlobalScript.inventory:
		print(GlobalScript.inventory[i])
