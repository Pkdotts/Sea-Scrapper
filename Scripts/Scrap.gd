extends Collectable
class_name Scrap

@onready var sfx = preload("res://Sound/SFX/scrap.wav")
@export var charge_amount = 1

func _ready() -> void:
	$Area2D/CollisionShape2D.set_deferred("disabled", true)

# Override
func set_sucking(enabled):
	super.set_sucking(enabled)
	$Area2D/CollisionShape2D.set_deferred("disabled", !enabled)

func collect(collector: Node2D):
	AudioManager.play_sfx(sfx, "scrap" + str(AudioManager.get_number_of_sfx()))
	collector.add_scraps(charge_amount)
	super.collect(collector)
