extends BasicEnemy
class_name ShootingEnemy


@export var timer_before_shooting = 1.0
@export var repeat_shot = false
@onready var bullet_pattern = $BulletPattern

var shoot_sfx = preload("res://Sound/SFX/bullet.wav")

func _ready() -> void:
	timer_before_shooting -= 0.02 * Global.get_difficulty()
	if timer_before_shooting < 0.7:
		timer_before_shooting = 0.7
	super._ready()

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
