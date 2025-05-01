extends Control
class_name Tutorial

@onready var tutorials = [$Basics, $BIGSHOT]
@onready var bigshot2 = $BIGSHOT2
@onready var smack2 = $Smack2
@onready var suck2 = $Suck2

func _ready() -> void:
	if Global.tutorial_passed:
		tutorials[0].set_to_appear_pos()
		bigshot2.set_to_appear_pos()
		suck2.set_to_appear_pos()
		smack2.set_to_appear_pos()

func hide_all():
	for i in tutorials:
		i.disappear()
	bigshot2.disappear()
	suck2.disappear()
	smack2.disappear()

func show_passed_tutorials():
	tutorials[0]
	bigshot2.appear()
	suck2.appear()
	smack2.appear()

func show_tutorial(tutorial: int):
	print("showing")
	tutorials[tutorial].appear()

func hide_tutorial(tutorial: int):
	tutorials[tutorial].disappear()
