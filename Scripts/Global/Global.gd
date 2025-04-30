extends Node

var persistCamera = null
var mainScene : MainScene = null
var persistPlayer : Player = null

signal updated_score
signal updated_level
signal game_overed

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

const START_SPEED = 20 # Originally 20
const SPEED_PER_DIFFICULTY = 3 # Originally 3

var speed : int = 0
const difficulty_speed_increment : int = 5
const MAX_LEVEL : int = 50

var score = 0
var highscore = 0

var gameover = false

var t_flags = [
	false,
	false,
	false,
	false
]

var timer: Timer

func _ready() -> void:
	AudioManager.play_title_music()



func start_game() -> void:
	player_hp = MAXHP
	AudioManager.play_game_music()
	UiCanvasLayer.add_gamehud_ui()

func check_and_show_tutorial(tut: int):
	if !t_flags[tut] and !t_flags[3]:
		print("global show " + str(tut))
		UiCanvasLayer.show_tutorial(tut)

func hide_tutorial(tut: int, enabled = true):
	if !t_flags[tut]:
		t_flags[tut] = enabled
		UiCanvasLayer.hide_tutorial(tut)

func pass_tutorial():
	speed = difficulty_speed_increment
	emit_signal("updated_level")

func set_gameover(enabled):
	gameover = enabled
	if enabled:
		UiCanvasLayer.hide_all_tutorials()
		UiCanvasLayer.gamehud.disappear()
		UiCanvasLayer.add_gameover_ui()
		AudioManager.play_title_music()

func return_to_title() -> void:
	UiCanvasLayer.circle_transition()
	await UiCanvasLayer.transition.transition_finished
	UiCanvasLayer.erase_gameover()
	get_tree().reload_current_scene()
	set_gameover(false)
	player_hp = MAXHP
	score = 0
	speed = 0

func add_hp(points) -> void:
	var new_hp = player_hp + points
	player_hp = max(min(new_hp, MAXHP), 0)
	UiCanvasLayer.update_hp()

func get_player_hp_percentage() -> float:
	return float(player_hp) / float(MAXHP)

func get_charge() -> int:
	return persistPlayer.charge



func add_level() -> void:
	if !gameover and t_flags[3]:
		if speed + 1 >= difficulty_speed_increment:
			return
		speed += 1
		emit_signal("updated_level")

func add_score(amount):
	if !gameover:
		score += amount
		emit_signal("updated_score")

func reset_score():
	score = 0

func get_difficulty() -> int:
	var difficulty = speed / difficulty_speed_increment
	if difficulty > MAX_LEVEL:
		difficulty = MAX_LEVEL
	return difficulty
		
