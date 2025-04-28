extends CharacterBody2D
class_name Player

enum States {MOVING, DASHING} 

@onready var sprite = $Sprite2D
@onready var gun = $Gun
@onready var melee = $MeleeAttack
@onready var DashTimer = $DashTimer
@onready var AfterImageCreator = $AfterImageCreator
@onready var animation_player = $AnimationPlayer
@onready var effects_player = $EffectsPlayer
@onready var bubble_spawner = $BubbleSpawner
@onready var bubble_spawner_timer : Timer = $BubbleSpawner/Timer



const NORMALSPEED = 6400.0
const DASHSPEED = 19000
const DECELERATION = 60000

var charge = 5
var charge_step = 5
var max_charge = 15

var gun_timer = 0
var gun_interval_time = 0.2

var direction = Vector2.ZERO
var inputVector = Vector2.ZERO

var speed = NORMALSPEED
var paused = false
var attacking = false
var state = States.MOVING
# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready() -> void:
	if OS.is_debug_build() and UiCanvasLayer.gamehud == null:
		UiCanvasLayer.add_gamehud_ui()

func _physics_process(delta):
	match state:
		States.MOVING:
			move_state(delta)
			attacks(delta)
		States.DASHING:
			dash_state(delta)

### INPUTS

func _input(event):
	if event.is_action_pressed("ui_shift") and !paused:
		start_dash()

func attacks(delta):
	if !attacking:
		if Input.is_action_just_pressed("ui_cancel"):
			animation_player.stop()
			animation_player.play("Attack")
			attacking = true
			gun_timer = 0
			
		# Shooting
		if animation_player.current_animation != "Attack":
			if Input.is_action_just_pressed("ui_accept") or gun_timer >= gun_interval_time:
				gun.spawn_bullet()
				gun_timer = 0
			
			if Input.is_action_pressed("ui_accept"):
				gun_timer += delta
			
			if Input.is_action_just_pressed("ui_select") and charge >= charge_step:
				charge -= charge_step
				gun.spawn_charge_shot()
				print("Big Shot")
	if Input.is_action_just_released("ui_accept"):
		gun_timer = 0

func add_scraps(amount):
	charge = min(charge + amount, max_charge)

func controls():
	if !paused:
		inputVector = ControlsManager.get_controls_vector(false)
		if inputVector != Vector2.ZERO:
			direction = inputVector




### MOVEMENT 

func move_state(delta):
	controls()
	var old_pos = position
	if speed > NORMALSPEED:
		speed -= DECELERATION * delta
		move(direction, speed, delta)
	else:
		speed = NORMALSPEED
		if AfterImageCreator.creating:
			AfterImageCreator.stop_creating()
		move(inputVector, speed, delta)
	
	position = position.round()

func dash_state(delta):
	move(direction, speed, delta)

func move(dir, spd, delta):
	if !paused:
		var oldPos = position
		velocity = dir * spd * delta
		move_and_slide()
		if position.round() == oldPos.round():
			position = position.round()
		
		if animation_player.current_animation != "Attack":
			if oldPos.x < position.x:
				animation_player.play("MoveForward")
			elif oldPos.x > position.x:
				animation_player.play("MoveBackwards")
			elif oldPos.y < position.y:
				animation_player.play("MoveForward")
			elif oldPos.y > position.y:
				animation_player.play("MoveBackwards")
			else:
				animation_player.play("Idle")

func start_dash():
	DashTimer.start()
	state = States.DASHING
	speed = DASHSPEED
	AfterImageCreator.start_creating()
	spawn_bubbles()

func spawn_bubbles():
	bubble_spawner_timer.stop()
	var bubbles_spawned = 6.0
	for i in bubbles_spawned:
		await get_tree().create_timer(0.04).timeout
		bubble_spawner.spawn_bubble(int((i / bubbles_spawned)  * 3))
	bubble_spawner_timer.start(0.0)

func stop_dashing():
	if state == States.DASHING:
		state = States.MOVING


func _on_dash_timer_timeout() -> void:
	stop_dashing()

# Getting Damaged

func damage():
	Global.add_hp(-1)
	effects_player.play("Flash")
	AfterImageCreator.stop_creating()
	Shaker.new(sprite, "offset", Vector2(1, 0), 3, 0.4, 0.04, Vector2(2, 0.5))
	Slowmo.start_slowmo(0.5, 0.2)
	if Global.player_hp <= 0:
		queue_free()

func hit_pause(time):
	await get_tree().create_timer(time).timeout
	animation_player.play()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_groups().has("EnemyAttack") and state != States.DASHING and !effects_player.is_playing():
		area.collide()
		damage()

func set_attacking(enabled: bool):
	attacking = enabled
