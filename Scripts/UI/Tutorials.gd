extends Control
class_name Tutorial

@onready var tutorials = [$Basics, $Smack, $BIGSHOT]
@onready var bigshot2 = $BIGSHOT2

func _ready() -> void:
	if Global.t_flags[2]:
		tutorials[0].set_to_appear_pos()
		tutorials[1].set_to_appear_pos()
		bigshot2.set_to_appear_pos()

func show_tutorial(tutorial: int):
	print("showing")
	tutorials[tutorial].appear()

func hide_tutorial(tutorial: int):
	tutorials[tutorial].disappear()
