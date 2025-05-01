extends Suckable

@onready var anim_player = $AnimationPlayer

func _ready() -> void:
	anim_player.play("Disappear")
	$Sprite2D.frame = randi() % 2

func _physics_process(delta: float) -> void:
	suck(delta)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == Global.persistPlayer:
		queue_free()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
