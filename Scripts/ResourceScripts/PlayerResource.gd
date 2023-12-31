extends Resource

class_name PlayerMealCarry

signal meal_given()
signal meal_taken()

@export var max_amt : int = 2
@export var rating_bonus_max : int = 25
@export var rating_increase_amt : int = 50
@export var rating_decrease_amt : int = 150

var meal_index : int
var carry_amt : int = 0

var rating : int = 0

# adds to rating, adds more if patience bar is higher
func adjust_rating(amt : int, patience_bar = null):
	rating += amt
	
	if patience_bar != null:
		rating += patience_bar.ratio * rating_increase_amt
	
	#GlobalScript.rating = rating

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
