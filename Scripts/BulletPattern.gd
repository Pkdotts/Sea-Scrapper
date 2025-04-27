extends Node
class_name BulletPattern

@export var bullet_amount = 0
@export var bullet_interval = 0.0
@export var bullet_spawner: NodePath
var bullet_spawner_node: BulletSpawner

func _ready() -> void:
	bullet_spawner_node = get_node_or_null(bullet_spawner)

func activate_bullet_spawner() -> void:
	for i in bullet_amount:
		bullet_spawner_node.spawn_bullet()
		await get_tree().create_timer(bullet_interval).timeout
