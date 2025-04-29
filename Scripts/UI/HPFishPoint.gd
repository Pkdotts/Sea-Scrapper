extends TextureRect
class_name HPFishPoint

var full = true

@onready var anim_player = $AnimationPlayer

func add():
	if !full:
		full = true
		anim_player.stop()
		anim_player.play("Add")

func remove():
	if full:
		full = false
		anim_player.stop()
		anim_player.play("Remove")
