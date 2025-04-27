extends BulletSpawner
class_name Gun

@export var charge_shot: PackedScene
#
#func activate_vaccuum():
	#

func spawn_charge_shot():
	spawn_object(charge_shot)
