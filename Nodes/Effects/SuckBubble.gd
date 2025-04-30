extends RigidBody2D

const SUCK_SPEED = 20
@onready var anim_player = $AnimationPlayer

func _ready() -> void:
	anim_player.play("Disappear")

func _physics_process(delta: float) -> void:
	var offset = Vector2(16, -10 * Global.persistPlayer.inputVector.y)
	var distance = global_position.distance_to(Global.persistPlayer.gun.global_position + offset)
	var distance_y = abs(global_position.y - Global.persistPlayer.gun.global_position.y + offset.y)
	var speed = max((SUCK_SPEED - distance), 20.0)
	var direction = global_position.direction_to(Global.persistPlayer.gun.global_position + offset * Vector2(1, 0)) 
	
	apply_impulse(direction * speed * Vector2(2, 0))
	position.y += direction.y * distance_y * 18 * delta 

func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
