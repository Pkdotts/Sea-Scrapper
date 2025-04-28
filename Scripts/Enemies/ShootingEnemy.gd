extends BasicEnemy
class_name ShootingEnemy


@export var timer_before_shooting = 1.0
@export var repeat_shot = false
@onready var bullet_pattern = $BulletPattern

func shoot():
	if state != States.DYING:
		bullet_pattern.activate_bullet_spawner()

func start_shooting():
	await get_tree().create_timer(timer_before_shooting).timeout
	if state != States.DYING:
		shoot()
		if repeat_shot:
			start_shooting()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	start_shooting()
