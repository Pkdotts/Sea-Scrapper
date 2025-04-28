extends RigidBody2D
class_name Collectable

const MAX_IMPULSE = 200
const MIN_IMPULSE = 100


func _ready() -> void:
	var pop_direction = Vector2(randf_range(0.5, 1), randf_range(-0.4, 0.4)).normalized()
	var pop_impulse = randi_range(MIN_IMPULSE, MAX_IMPULSE)
	apply_impulse(pop_direction * pop_impulse)

func _physics_process(delta: float) -> void:
	if global_position.x < -50:
		queue_free()
