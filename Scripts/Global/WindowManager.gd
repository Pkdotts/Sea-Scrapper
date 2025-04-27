extends Node

var winSize = 1

func _ready():
	resize_window(3)

func _input(event):
	if event.is_action_pressed("F4"):
		match DisplayServer.window_get_mode():
			DisplayServer.WINDOW_MODE_WINDOWED:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.WINDOW_MODE_FULLSCREEN:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	

func resize_window(scale):
	var newSize = (Vector2i(320, 180) * scale)
	DisplayServer.window_set_position(DisplayServer.window_get_position() - newSize/scale)
	DisplayServer.window_set_size(Vector2i(320, 180) * scale)
