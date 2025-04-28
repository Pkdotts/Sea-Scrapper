extends Spawner
class_name BulletSpawner

@export var bullet : PackedScene

func spawn_bullet() -> Node2D:
	return spawn_object(bullet)
