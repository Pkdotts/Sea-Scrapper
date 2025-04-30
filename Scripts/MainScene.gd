extends Node2D
class_name MainScene

@onready var pattern_spawner : EnemyPatternSpawner = $EnemyPatternSpawner

func _ready() -> void:
	UiCanvasLayer.add_title_ui()
	Global.mainScene = self

func start_game():
	UiCanvasLayer.add_gamehud_ui()
	if !Global.t_flags[2]:
		await get_tree().create_timer(3).timeout
	else:
		UiCanvasLayer.hide_tutorial(0)
	
	pattern_spawner.spawn_pattern()
