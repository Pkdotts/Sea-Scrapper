extends Collectable

func collect(collector: Node2D):
	Global.add_hp(1)
	super.collect(collector)
