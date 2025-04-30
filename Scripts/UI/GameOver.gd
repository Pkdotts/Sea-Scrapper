extends Control
class_name GameOver

var pressed = false

@onready var score = $Score
@onready var highscore = $Highscore
@onready var level = $Level
@onready var newhighscore = $NewHighscore

func _ready() -> void:
	score.display_number(Global.score)
	highscore.display_number(Global.highscore)
	level.display_number(Global.get_difficulty())
	if Global.score > Global.highscore:
		newhighscore.show()
	else:
		newhighscore.hide()
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") and !pressed:
		pressed = true
		Global.return_to_title()
