extends Control

@export var resources : PlayerResource
@export var game_manager : GameManager

@onready var background = %Background
@onready var condition_text = %ConditionText
@onready var day_label = %DayLabel

var click = load("res://Assets/SFX/click_sfx.ogg")
var victory_sfx = load("res://Assets/Music/Good Job!.wav")
var current_qouta : float = 0
var game_finished : bool = false

var tween

func _ready():
	game_manager.day_end.connect(_end_day)
	day_label.text = "Day: " + str(GlobalScript.days)
	next_day()

func next_day():
	day_label.show()
	await get_tree().create_timer(1).timeout
	
	if tween:
		tween.kill()
	
	tween = get_tree().create_tween()
	tween.tween_property(day_label, "global_position:y", day_label.global_position.y - 256, 1)
	tween.parallel().tween_property(day_label, "modulate", Color("ffffff00"), 1)
	await tween.finished
	day_label.hide()

func _end_day():
	AudioManager.play_sound(victory_sfx)
	game_manager._reset()
	condition_text.show()
	background.show()
	
	if tween:
		tween.kill()
	
	tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(condition_text, "scale", Vector2(1, 1), 1)
	tween.parallel().tween_property(condition_text, "modulate", Color("ffffff"), 1)
	tween.parallel().tween_property(background, "color", Color("0000009b"), 1)
	
	await get_tree().create_timer(5).timeout
	SceneManager.change_scene("res://Nodes/UI/result_screen.tscn", {"pattern":"circle"})
