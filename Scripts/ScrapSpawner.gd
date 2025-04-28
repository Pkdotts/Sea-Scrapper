extends Spawner

@export var scrap : PackedScene
@export var amount = 3

func _ready() -> void:
	set_new_parent(get_tree().current_scene)

func spawn_scraps() -> void:
	for i in amount:
		spawn_object(scrap)
