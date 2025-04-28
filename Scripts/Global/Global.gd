extends Node

var persistCamera = null

const MAXHP = 15
var player_hp = 15

var difficulty = 0


func start_game():
	player_hp = MAXHP

func add_hp(points):
	print("adding hp")
	player_hp += points
	UiCanvasLayer.update_hp()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
