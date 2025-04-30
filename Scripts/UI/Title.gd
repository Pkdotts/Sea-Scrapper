extends Control
class_name Title

@onready var anim_player = $AnimationPlayer
var hid = false

func _ready() -> void:
	UiCanvasLayer.add_tutorial_ui()
	anim_player.play("Sway")
	$Highscore.display_number(Global.highscore)

func hide_title():
	anim_player.play("Hide")
	hid = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and !hid:
		hide_title()
		Global.persistPlayer.unpause()
		Global.mainScene.start_game()
