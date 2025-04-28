extends Sprite2D

@onready var anim_player = $AnimationPlayer
@onready var amplitude = 4.0
@onready var speed = 4.0
@onready var float_speed = 40.0
var og_pos_x = 0
var og_time = 0.0


func _ready():
	frame = randi_range(0, 2)
	await draw
	og_pos_x = global_position.x
	og_time = Time.get_ticks_msec() / 1000.0
	anim_player.play("Disappear")



func _physics_process(delta):
	position.y -= float_speed * delta
	position.x = cos(Time.get_ticks_msec() / 1000.0 * speed + og_time) * amplitude + og_pos_x
	
	if position.y < -8:
		queue_free()

func _on_animation_player_animation_finished(anim_name):
	queue_free()
