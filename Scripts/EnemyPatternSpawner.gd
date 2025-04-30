extends Node2D
class_name EnemyPatternSpawner

var last_pattern = 0

func spawn_pattern():
	var patterns = Global.PATTERNS
	var level = min(Global.get_difficulty(), patterns.size() - 1)
	if level > 0:
		level = randi_range(level, level - 1)
	var random_pattern = randi() % patterns[level].size()
	if last_pattern == random_pattern:
		random_pattern += 1
		if random_pattern > patterns[level].size() - 1:
			random_pattern = 0
	last_pattern = random_pattern
	var pattern : EnemyPattern = patterns[level][random_pattern].instantiate()
	
	call_deferred("add_child", pattern)
	pattern.update_speed()
	pattern.passed_parent.connect(spawn_pattern)
	
	print("added")
