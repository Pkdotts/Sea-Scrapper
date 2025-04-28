extends Node2D
class_name EnemyPattern

signal passed_parent

@onready var visibility_notifier = $VisibleOnScreenNotifier2D

@export var speed = 200
@export var direction = Vector2(-1, 0)

var passed = false

func get_right_end_position() -> float:
	return visibility_notifier.rect.end.x * visibility_notifier.scale.x + visibility_notifier.position.x + global_position.x

func _process(delta: float) -> void:
	position += direction * speed * delta
	
	if !passed and get_parent().global_position.x > get_right_end_position():
		passed = true
		print("passed")
		passed_parent.emit()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
