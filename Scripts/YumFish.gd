extends Collectable

var sfx = preload("res://Sound/SFX/yum.wav")
func collect(collector: Node2D):
	Global.add_hp(1)
	AudioManager.play_sfx(sfx, "yum")
	super.collect(collector)
