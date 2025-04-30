extends RigidBody2D
class_name Collectable

const MAX_IMPULSE = 200
const MIN_IMPULSE = 100
const SUCK_SPEED = 80
const effectPath = "res://Nodes/Bullets/BulletEffect.tscn"

var sucked = false

func _ready() -> void:
	var pop_direction = Vector2(randf_range(0.5, 1), randf_range(-0.4, 0.4)).normalized()
	var pop_impulse = randi_range(MIN_IMPULSE, MAX_IMPULSE)
	apply_impulse(pop_direction * pop_impulse)

func _physics_process(delta: float) -> void:
	if sucked:
		var offset = Vector2(16, -10 * Global.persistPlayer.inputVector.y)
		var distance = global_position.distance_to(Global.persistPlayer.gun.global_position + offset)
		var distance_y = abs(global_position.y - Global.persistPlayer.gun.global_position.y + offset.y)
		var speed = max(10, randf_range(SUCK_SPEED - distance, 10.0))
		var direction = global_position.direction_to(Global.persistPlayer.gun.global_position) * Vector2(distance / 20.0, max(5.0, 2.2 * distance_y))
		apply_impulse(direction * speed)
	if global_position.x < -32:
		queue_free()

func set_sucking(enabled):
	sucked = enabled

func collect(collector: Node2D):
	create_effect("ItemCollect")
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_groups().has("Player"):
		collect(body)

func create_effect(anim):
	var effect = preload(effectPath)
	var effectNode = effect.instantiate()
	get_parent().add_child(effectNode)
	effectNode.global_position = self.global_position
	effectNode.play(anim)
