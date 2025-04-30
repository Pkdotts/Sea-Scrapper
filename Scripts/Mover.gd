extends Node2D
class_name EnemyPattern

signal passed_parent

@onready var visibility_notifier = $VisibleOnScreenNotifier2D

var speed = 200
var direction = Vector2(-1, 0)

var passed = false

func _ready() -> void:
	Global.updated_level.connect(update_speed)

func update_speed():
	speed = Global.START_SPEED + Global.SPEED_PER_DIFFICULTY * Global.get_difficulty()

func get_right_end_position() -> float:
	return visibility_notifier.rect.end.x * visibility_notifier.scale.x + visibility_notifier.position.x + global_position.x

func _process(delta: float) -> void:
	position += direction * speed * delta
	
	if !passed and (get_child_count() <= 1 or get_parent().global_position.x > get_right_end_position()):
		passed = true
		Global.add_level()
		print("passed")
		passed_parent.emit()
		if get_child_count() <= 1:
			queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
