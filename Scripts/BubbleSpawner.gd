extends BulletSpawner
class_name BubbleSpawner

func spawn_bubble(frame: int) -> Node2D:
	var bubble : Sprite2D = spawn_bullet()
	bubble.frame = frame
	return bubble
