extends RigidBody2D
class_name Scrap

@export var charge_amount = 1

const MAX_IMPULSE = 200
const MIN_IMPULSE = 100

var pop_direction = Vector2.ZERO

func _ready() -> void:
	var pop_direction = Vector2(randf_range(0.5, 1), randf_range(-0.4, 0.4)).normalized()
	var pop_impulse = randi_range(MIN_IMPULSE, MAX_IMPULSE)
	apply_impulse(pop_direction * pop_impulse)

func _physics_process(delta: float) -> void:
	if global_position.x < -50:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_groups().has("Player"):
		body.add_scraps(charge_amount)
		queue_free()
