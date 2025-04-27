extends AttackArea
class_name Bullet

const effectPath = "res://Nodes/Bullets/BulletEffect.tscn"


@export var startAnim = ""
@export var idleAnim = ""
@export var endAnim = ""
@export var direction = Vector2(1, 0)
@export var speed = 300
@export var destroy_on_hit = true

@onready var animatedSprite = $AnimatedSprite2D

func _ready() -> void:
	animatedSprite.play(idleAnim)
	await draw
	create_effect(startAnim)

func set_direction(dir: Vector2):
	direction = dir

func set_speed(spd: float):
	speed = spd

func _physics_process(delta):
	_movement(delta)

func _movement(delta) -> void:
	position += direction * speed * delta

func create_effect(anim):
	var effect = preload(effectPath)
	var effectNode = effect.instantiate()
	get_parent().add_child(effectNode)
	effectNode.global_position = self.global_position
	effectNode.play(anim)

func collide():
	if destroy_on_hit:
		create_effect(endAnim)
		queue_free()

func _on_animated_sprite_2d_animation_finished() -> void:
	if animatedSprite.animation == startAnim:
		animatedSprite.play(idleAnim)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
