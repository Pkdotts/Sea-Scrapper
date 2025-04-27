extends Node2D

@export var speed = 200
@export var direction = Vector2(-1, 0)

func _process(delta: float) -> void:
	position += direction * speed * delta
