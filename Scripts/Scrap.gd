extends Collectable
class_name Scrap

@export var charge_amount = 1


func collect(collector: Node2D):
	collector.add_scraps(charge_amount)
	super.collect(collector)
