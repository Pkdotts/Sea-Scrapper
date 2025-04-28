extends Collectable
class_name Scrap

@export var charge_amount = 1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_groups().has("Player"):
		body.add_scraps(charge_amount)
		queue_free()
