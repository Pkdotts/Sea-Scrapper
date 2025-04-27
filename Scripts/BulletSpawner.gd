extends Spawner
class_name BulletSpawner

@export var bullet : PackedScene

func spawn_bullet() -> void:
	spawn_object(bullet)
