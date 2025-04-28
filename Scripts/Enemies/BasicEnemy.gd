extends CharacterBody2D
class_name Enemy

enum States {MOVING, DYING}

@export var hp = 15
@export var vulnerabilityThreshold = 10
@export var timer_before_shooting = 1.0
@export var repeat_shot = false

@onready var FlashPlayer = $FlashPlayer
@onready var Sprite = $Sprite2D
@onready var ScrapSpawner = $ScrapSpawner
@onready var bullet_pattern = $BulletPattern
@onready var visibility_notifier = $VisibleOnScreenNotifier2D

var death_sfx = preload("res://Sound/SFX/metal_pipe.mp3")

const KNOCKBACKSPEED = 400
const KNOCKBACKSPEEDMELEE = 400
const KNOCKBACKDECELERATE = 2000
const MOVESPEED = 1000



var state = States.MOVING

var meleed = false

func _physics_process(delta: float) -> void:
	match state:
		States.DYING:
			velocity.x -= KNOCKBACKDECELERATE * delta
			move_and_slide()
			if velocity.x <= 0:
				die()
		States.MOVING:
			movement(delta)

# Abstract
func movement(delta):
	#velocity.x = -MOVESPEED * delta
	#move_and_slide()
	pass

# Abstract
func shoot():
	await get_tree().create_timer(timer_before_shooting).timeout
	if !is_vulnerable():
		if state != States.DYING:
			bullet_pattern.activate_bullet_spawner()
			if repeat_shot:
				shoot()

func damage(amt, groups):
	hp -= amt
	if hp <= 0:
		if groups.has("Bullet"):
			start_dying(KNOCKBACKSPEED)
		elif groups.has("Melee"):
			meleed = true
			start_dying(KNOCKBACKSPEEDMELEE)
	elif groups.has("Melee"):
		var shaker = Shaker.new(Sprite, "offset", Vector2(1, 0), 2, 0.2, 0.03, Vector2(0.5, 1.5))
	FlashPlayer.stop()
	if is_vulnerable():
		FlashPlayer.play("VulnerabilityFlash")
	else:
		FlashPlayer.play("Flash")

func is_vulnerable() -> bool:
	return hp <= vulnerabilityThreshold

func start_dying(knockback) -> void:
	AudioManager.play_sfx(death_sfx, "melee")
	AudioManager.set_sfx_pitch("melee", randf_range(0.95, 1.1))
	await get_tree().create_timer(0.12).timeout
	state = States.DYING
	velocity = Vector2(knockback, 0)

func die() -> void:
	if meleed:
		ScrapSpawner.spawn_scraps()
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if visibility_notifier.is_on_screen():
		var area_groups = area.get_groups()
		if area_groups.has("PlayerAttack") and state != States.DYING:
			area.collide()
			if area_groups.has("Melee") and hp <= vulnerabilityThreshold:
				damage(vulnerabilityThreshold, area_groups)
			else:
				damage(area.damage, area_groups)

func _on_flash_player_animation_finished(anim_name: StringName) -> void:
	if "Flash" in anim_name && hp <= vulnerabilityThreshold:
		FlashPlayer.play("Vulnerable")


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	shoot()
