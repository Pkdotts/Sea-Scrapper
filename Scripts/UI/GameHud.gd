extends CanvasLayer
class_name GameHud

@onready var hp_bar = $HPBar

func update_hp():
	hp_bar.update_hp()
