extends Node

var persistCamera = null
var persistPlayer : Player = null

const PATTERNS = [
	[ # Difficulty 1
		preload("res://Nodes/EnemyPatterns/EP1_1.tscn"),
		preload("res://Nodes/EnemyPatterns/EP1_2.tscn"),
		preload("res://Nodes/EnemyPatterns/EP1_3.tscn")
	],[ #Difficulty 2
		preload("res://Nodes/EnemyPatterns/EP2_1.tscn"),
		preload("res://Nodes/EnemyPatterns/EP2_2.tscn")
	],[ #Difficulty 3
		preload("res://Nodes/EnemyPatterns/EP3_1.tscn"),
		preload("res://Nodes/EnemyPatterns/EP3_2.tscn"),
		preload("res://Nodes/EnemyPatterns/EP3_3.tscn")
	],[ #Difficulty 4
		preload("res://Nodes/EnemyPatterns/EP4_1.tscn"),
		preload("res://Nodes/EnemyPatterns/EP4_2.tscn")
	],[ #Difficulty 5
		preload("res://Nodes/EnemyPatterns/EP5_1.tscn"),
		preload("res://Nodes/EnemyPatterns/EP5_2.tscn")
	]
]

const MAXHP : int = 6
var player_hp : int = 6

var level : int = 0
const difficulty_level_increment : int = 6

var timer: Timer

func _ready() -> void:
	start_game()

func start_game() -> void:
	player_hp = MAXHP

func add_hp(points) -> void:
	var new_hp = player_hp + points
	player_hp = max(min(new_hp, MAXHP), 0)
	UiCanvasLayer.update_hp()

func get_player_hp_percentage() -> float:
	return float(player_hp) / float(MAXHP)

func get_charge() -> int:
	return persistPlayer.charge

func add_level() -> void:
	print("add")
	level += 1

func get_difficulty() -> int:
	return level / difficulty_level_increment
