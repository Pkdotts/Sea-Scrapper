extends CanvasLayer
class_name GameHud

@onready var hp_bar = $HBoxContainer/HPBar
@onready var scrap_bar = $HBoxContainer/ScrapBar

func update_hp():
	hp_bar.update_hp()

func update_bar(time: float):
	scrap_bar.update_bar(time)
