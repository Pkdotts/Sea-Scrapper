extends HBoxContainer

var max_hp: int
@onready var HP_fish = preload("res://UI/HPFishPoint.tscn")

func _ready() -> void:
	max_hp = Global.MAXHP
	#for i in get_children():
		#i.queue_free()
	for i in max_hp:
		var HP_node = HP_fish.instantiate()
		add_child(HP_node)
	

func update_hp():
	print(Global.player_hp)
	for i in get_child_count():
		var fish:HPFishPoint = get_child(i)
		if i < Global.player_hp:
			fish.add()
		else:
			fish.remove()
