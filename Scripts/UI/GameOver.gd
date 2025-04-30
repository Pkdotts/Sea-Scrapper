extends Control
class_name GameOver

var pressed = false

@onready var score = $Score
@onready var highscore = $Highscore
@onready var level = $Level
@onready var newhighscore = $NewHighscore

func _ready() -> void:
	pressed = false
	if Global.score > Global.highscore:
		newhighscore.show()
		Global.highscore = Global.score
	else:
		newhighscore.hide()
	score.display_number(Global.score)
	highscore.display_number(Global.highscore)
	level.display_number(Global.get_difficulty())

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and !pressed:
		print("pressed!")
		pressed = true
		Global.return_to_title()
