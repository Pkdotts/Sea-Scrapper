extends RigidBody2D
class_name Suckable

const SUCK_SPEED = 20

func suck(delta: float) -> void:
	var offset = Vector2(8, -10 * Global.persistPlayer.inputVector.y)
	var distance = global_position.distance_to(Global.persistPlayer.gun.global_position + offset)
	var distance_y = abs(global_position.y - Global.persistPlayer.gun.global_position.y + offset.y)
	var speed = max((SUCK_SPEED - distance), 20.0)
	var direction = global_position.direction_to(Global.persistPlayer.gun.global_position + offset * Vector2(1, 0)) 
	
	apply_impulse(direction * speed * Vector2(2, 0))
	position.y += direction.y * distance_y * 18 * delta 
