extends AttackArea

@onready var animationPlayer = $AnimationPlayer

func start_attack():
	animationPlayer.stop()
	animationPlayer.play("Attack")

func collide():
	hit_pause(0.07)

func hit_pause(time):
	animationPlayer.pause()
	await get_tree().create_timer(time).timeout
	animationPlayer.play()
