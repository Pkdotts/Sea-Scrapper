extends Spawner
class_name ItemSpawner

@export var item : PackedScene
@export var amount = 1
@export var interval = 0.0
@export var random_spawn_size = Vector2.ZERO

func _ready() -> void:
	set_new_parent(get_tree().current_scene)

func spawn_items() -> void:
	for i in amount:
		var item = spawn_object(item)
		item.position += Vector2(
			randf_range(-random_spawn_size.x, random_spawn_size.x), 
			randf_range(-random_spawn_size.y, random_spawn_size.y))
		if interval > 0.0:
			await get_tree().create_timer(interval).timeout
