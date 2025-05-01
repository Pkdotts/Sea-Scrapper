extends ShootingEnemy
class_name RoboSquid

@export var speed_multiplier = 1.0
const AMPLITUDE = 32.0
const SPEED = 1
const MOVE_SPEED = 40.0
var og_pos_y : float

func _ready() -> void:
	super._ready()
	og_pos_y = global_position.y

# Override
func movement(delta):
	global_position.y = speed_multiplier * cos(Time.get_ticks_msec() / 1000.0 * SPEED) * AMPLITUDE + og_pos_y 

func shoot():
	if state != States.DYING:
		anim_player.play("Shoot")

func shoot_bullet():
	if state != States.DYING:
		bullet_pattern.activate_bullet_spawner()
		AudioManager.play_sfx(shoot_sfx, "shoot")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Shoot":
		anim_player.play("Idle")
