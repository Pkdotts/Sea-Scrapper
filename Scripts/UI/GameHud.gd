extends Control
class_name GameHud

@onready var hp_bar = $HBoxContainer/HPBar
@onready var scrap_bar = $HBoxContainer/ScrapBar
@onready var score = $LevelScore/Score
@onready var level = $LevelScore/Level

const HIDDENPOSY = -80
var appear_pos_y : float

var shown = false

func _ready() -> void:
	appear_pos_y = position.y
	position.y = HIDDENPOSY
	appear()
	Global.updated_score.connect(update_score)
	Global.updated_level.connect(update_level)
	update_score()
	update_level()

func update_score():
	score.display_number(Global.score)

func update_level():
	level.display_number(Global.get_difficulty())

func appear():
	if !shown:
		shown = true
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position:y", appear_pos_y, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
		tween.play()
		print("hiiii")

func disappear():
	if shown:
		shown = false
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position:y", HIDDENPOSY, 0.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUART)
		tween.play()

func update_hp():
	hp_bar.update_hp()

func update_bar(time: float):
	scrap_bar.update_bar(time)
