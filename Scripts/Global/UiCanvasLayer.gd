extends CanvasLayer

@onready var transition_ui = preload("res://UI/Transition.tscn")
@onready var gamehud_ui = preload("res://UI/GameHud.tscn")

var transition : Transition = null
var gamehud : GameHud = null

func add_gamehud_ui():
	erase_gamehud()
	gamehud = gamehud_ui.instantiate()
	add_child(gamehud)
	

func erase_gamehud():
	if gamehud != null:
		gamehud.queue_free()
		gamehud = null

func update_hp():
	if gamehud != null:
		print("ui canvas update hp")
		gamehud.update_hp()

func erase_transition():
	if transition != null:
		transition.queue_free()
		transition = null

func circle_in():
	erase_transition()
	var transitionUI = transition_ui.instantiate()
	add_child(transitionUI)
	transition = transitionUI
	transition.circlein()

func circle_out():
	if transition != null:
		transition.circleout()
		transition.connect("transition_finished", remove_transition)

func remove_transition():
	transition.queue_free()
	transition = null

func circle_transition():
	if transition==null:
		var transitionUI = transition_ui.instantiate()
		add_child(transitionUI)
		transition = transitionUI
		transition.circlein()
		await transition.transition_finished
		transition.circleout()
		await transition.transition_finished
