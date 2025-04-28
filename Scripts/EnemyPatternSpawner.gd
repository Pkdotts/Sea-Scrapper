extends Node2D
class_name EnemyPatternSpawner

@export var speed = 20
var last_pattern = 0

const PATTERNS = [
	# Difficulty 1
	[
		preload("res://Nodes/EnemyPatterns/EnemyPattern1.tscn"),
		preload("res://Nodes/EnemyPatterns/EnemyPattern2.tscn")
	],
	#Difficulty 2
	[
		preload("res://Nodes/EnemyPatterns/EnemyPattern3.tscn")
	]
]

func _ready() -> void:
	spawn_pattern()

func spawn_pattern():
	var level = Global.difficulty
	var random_pattern = randi() % PATTERNS[level].size()
	if last_pattern == random_pattern:
		random_pattern += 1
		if random_pattern > PATTERNS[level].size() - 1:
			random_pattern = 0
	last_pattern = random_pattern
	var pattern : EnemyPattern = PATTERNS[level][random_pattern].instantiate()
	
	call_deferred("add_child", pattern)
	pattern.speed = speed
	pattern.passed_parent.connect(spawn_pattern)
	
	print("added")
