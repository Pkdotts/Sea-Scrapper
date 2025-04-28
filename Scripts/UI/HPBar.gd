extends Control

var max_hp: int
@onready var HP_fish = preload("res://UI/HPFishPoint.tscn")
@onready var HP_container : HBoxContainer = $HPContainer

func _ready() -> void:
	max_hp = Global.MAXHP
	for i in max_hp:
		var HP_node = HP_fish.instantiate()
		HP_container.add_child(HP_node)

func update_hp():
	print(Global.player_hp)
	for i in HP_container.get_child_count():
		var fish:HPFishPoint = HP_container.get_child(i)
		if i < Global.player_hp:
			fish.add()
		else:
			fish.remove()
