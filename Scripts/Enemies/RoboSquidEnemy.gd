extends ShootingEnemy
class_name RoboSquid

const AMPLITUDE = 32.0
const SPEED = 1
const MOVE_SPEED = 40.0
var og_time : float = 0.0
var og_pos_y : float

func _ready() -> void:
	super._ready()
	og_pos_y = global_position.y
	og_time = Time.get_ticks_msec() / 1000.0

# Override
func movement(delta):
	global_position.y = cos(Time.get_ticks_msec() / 1000.0 * SPEED + og_time) * AMPLITUDE + og_pos_y 

func shoot():
	if state != States.DYING:
		anim_player.play("Shoot")

func shoot_bullet():
	if state != States.DYING:
		bullet_pattern.activate_bullet_spawner()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Shoot":
		anim_player.play("Idle")
