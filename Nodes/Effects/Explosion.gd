extends AnimatedSprite2D

@export var start_anim = ""

func _ready() -> void:
	play(start_anim)
	await animation_finished
	queue_free()
