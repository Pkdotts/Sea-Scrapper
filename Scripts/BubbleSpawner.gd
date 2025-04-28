extends BulletSpawner
class_name BubbleSpawner

@export var auto_spawn : bool = false
@export var timer_one_shot : bool = false
@export var timer_wait_time : float = 0.0
@export var random_spawn_start : bool = false

var timer : Timer

func _ready() -> void:
	if auto_parent:
		new_parent = get_tree().current_scene
	if auto_spawn:
		if timer_one_shot and timer_wait_time == 0.0:
			await draw
			spawn_bullet()
		else:
			timer = Timer.new()
			timer.timeout.connect(spawn_bullet)
			timer.one_shot = timer_one_shot
			
			add_child(timer)
			if random_spawn_start:
				timer.start(randf() * timer_wait_time)
			else:
				timer.start(timer_wait_time)

func spawn_bullet() -> Node2D:
	if random_spawn_start:
		timer.wait_time = timer_wait_time
	return super.spawn_bullet()

func spawn_bubble(frame: int) -> Node2D:
	var bubble : Sprite2D = spawn_bullet()
	bubble.frame = frame
	return bubble
