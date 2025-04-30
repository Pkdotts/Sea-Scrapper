extends CharacterBody2D
class_name BasicEnemy

enum States {MOVING, DYING}

@export var score = 100
@export var hp = 15
@export var vulnerabilityThreshold = 10

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var FlashPlayer : AnimationPlayer = $FlashPlayer
@onready var Sprite : Sprite2D = $Sprite2D
@onready var ScrapSpawner : ItemSpawner = $ScrapSpawner
@onready var fish_spawner : ItemSpawner = $FishSpawner
@onready var explosion_spawner : ItemSpawner = $ExplosionSpawner
@onready var visibility_notifier : VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var hitbox = $Hitbox
#@onready var electric_effect = $ElectricityEffect
@onready var vulnerability_bang = $VulnerabilityBang

var death_sfx = preload("res://Sound/SFX/metal_pipe.mp3")

const KNOCKBACKSPEED = 400
const KNOCKBACKSPEEDMELEE = 400
const KNOCKBACKDECELERATE = 2000
const MOVESPEED = 1000

var state = States.MOVING

var im_dying = false
var meleed = false

var shake_timer = 0.0
const SHAKETIMERSTEP = 0.015

func _ready() -> void:
	anim_player.play("Idle")
	vulnerability_bang.hide()

func _physics_process(delta: float) -> void:
	match state:
		States.DYING:
			dying(delta)
		States.MOVING:
			movement(delta)
			if is_vulnerable():
				vulnerable_shake(delta)
			
			

func vulnerable_shake(delta):
	shake_timer += delta
	if shake_timer >= SHAKETIMERSTEP:
		Sprite.offset = Vector2(randi_range(-1, 1), randi_range(-1, 1))
		shake_timer = 0

func dying(delta):
	velocity.x -= KNOCKBACKDECELERATE * delta
	move_and_slide()
	if velocity.x <= 0:
		die()

# Abstract
func movement(delta):
	#velocity.x = -MOVESPEED * delta
	#move_and_slide()
	pass

func damage(amt, groups):
	hp -= amt
	if hp <= 0:
		if groups.has("Bullet"):
			start_dying(KNOCKBACKSPEED)
			Global.hide_tutorial(1, false)
		elif groups.has("Melee"):
			meleed = true
			start_dying(KNOCKBACKSPEEDMELEE)
			Global.hide_tutorial(1, false)
	elif groups.has("Melee"):
		var shaker = Shaker.new(Sprite, "offset", Vector2(1, 0), 2, 0.2, 0.03, Vector2(0.5, 1.5))
	FlashPlayer.stop()
	if is_vulnerable():
		if !FlashPlayer.is_playing() and hp != 0:
			vulnerability_bang.show()
			vulnerability_bang.play("default")
		FlashPlayer.play("VulnerabilityFlash")
			
		if !im_dying:
			Global.check_and_show_tutorial(1)
	else:
		FlashPlayer.play("Flash")


func is_vulnerable() -> bool:
	return hp <= vulnerabilityThreshold

func start_dying(knockback) -> void:
	var sfx_name = "melee" + str(AudioManager.get_number_of_sfx())
	AudioManager.play_sfx(death_sfx, sfx_name)
	AudioManager.set_sfx_pitch(sfx_name , randf_range(0.95, 1.1))
	explosion_spawner.spawn_items()
	create_bubble_explosion()
	hitbox.queue_free()
	im_dying = true
	await get_tree().create_timer(0.12).timeout
	state = States.DYING
	velocity = Vector2(knockback, 0)

func create_bubble_explosion():
	var bubble_explosion = ItemSpawner.new()
	bubble_explosion.item = preload("res://Nodes/Effects/Bubble.tscn")
	bubble_explosion.amount = 6
	bubble_explosion.interval = 0.025
	bubble_explosion.random_spawn_size = Vector2(10, 10)
	self.add_child(bubble_explosion)
	bubble_explosion.call_deferred("spawn_items")

func die() -> void:
	if !meleed:
		if Global.t_flags[1]:
			ScrapSpawner.amount = 1
		else:
			ScrapSpawner.amount = 0
	ScrapSpawner.spawn_items()
	fish_spawner.spawn_items()
	if Global.t_flags[3]:
		Global.add_score(score)
	Global.check_and_show_tutorial(2)
	
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if visibility_notifier.is_on_screen() and !im_dying:
		var area_groups = area.get_groups()
		if area_groups.has("PlayerAttack") and state != States.DYING:
			area.collide()
			if area_groups.has("Melee") and hp <= vulnerabilityThreshold:
				damage(vulnerabilityThreshold, area_groups)
			else:
				damage(area.damage, area_groups)

func _on_flash_player_animation_finished(anim_name: StringName) -> void:
	if "Flash" in anim_name && hp <= vulnerabilityThreshold and hp != 0:
		FlashPlayer.play("Vulnerable")
		#electric_effect.show()
		#electric_effect.play("default")
		
