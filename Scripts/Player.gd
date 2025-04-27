extends CharacterBody2D
class_name Player

enum States {MOVING, DASHING} 

@onready var sprite = $Sprite2D
@onready var gun = $Gun
@onready var melee = $MeleeAttack
@onready var DashTimer = $DashTimer
@onready var AfterImageCreator = $AfterImageCreator
@onready var animation_player = $AnimationPlayer


const NORMALSPEED = 6400.0
const DASHSPEED = 19000
const DECELERATION = 49000

var charge = 5
var charge_step = 5
var max_charge = 15

var direction = Vector2.ZERO
var inputVector = Vector2.ZERO

var speed = NORMALSPEED
var paused = false
var state = States.MOVING
# Get the gravity from the project settings to be synced with RigidBody nodes.


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
	if Input.is_action_just_pressed("ui_cancel"):
		melee.start_attack()
	# Shooting
	
	if Input.is_action_just_pressed("ui_accept"):
		gun.spawn_bullet()
	
	if Input.is_action_just_pressed("ui_select") and charge >= charge_step:
		charge -= charge_step
		gun.spawn_charge_shot()
		print("Big Shot")

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
	#$TackleArea/CollisionShape2D.disabled = false
	#$DashSound.play()
	#animationPlayer.play("Dash")

func stop_dashing():
	if state == States.DASHING:
		state = States.MOVING
		
		
		#$TackleArea/CollisionShape2D.set_deferred("disabled", true)

func _on_dash_timer_timeout() -> void:
	stop_dashing()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_groups().has("EnemyAttack") and state != States.DASHING:
		AfterImageCreator.stop_creating()
		area.collide()
		Shaker.new(sprite, "offset", Vector2(1, 0), 3, 0.4, 0.04, Vector2(2, 0.5))
		Slowmo.start_slowmo(0.5, 0.2)
