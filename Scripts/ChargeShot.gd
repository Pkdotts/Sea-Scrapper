extends Bullet
class_name ChargeShot

var sfx = preload("res://Sound/SFX/bigshot.wav")

func _ready() -> void:
	AudioManager.play_sfx(sfx, "bigshot")
	super._ready()

func collide():
	Global.add_score(500)
