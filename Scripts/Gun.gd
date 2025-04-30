extends BulletSpawner
class_name Gun

@export var charge_shot: PackedScene
@onready var collision_shapes = [
	$Area2D/CollisionShape2D,
	$StaticBody2D/CollisionShape2D,
	$StaticBody2D/CollisionShape2D2,
	$StaticBody2D/CollisionShape2D3
]

@onready var bubble_spawner = $BubbleSpawner

var time = 0
var sucking = false
const SPAWN_TIME = 0.06


func _ready() -> void:
	super._ready()
	set_collision_shapes(true)

func _physics_process(delta: float) -> void:
	if sucking:
		time += delta
		if time >= SPAWN_TIME:
			bubble_spawner.spawn_items()
			time = 0

func spawn_charge_shot():
	spawn_object(charge_shot)

func activate_vaccuum():
	set_collision_shapes(false)
	sucking = true
	

func deactivate_vaccuum():
	set_collision_shapes(true)
	time = 0
	sucking = false

func set_collision_shapes(enabled):
	for i in collision_shapes:
		i.disabled = enabled

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_groups().has("Collectable"):
		body.set_sucking(true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.get_groups().has("Collectable"):
		body.set_sucking(false)
