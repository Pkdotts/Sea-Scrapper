extends Container

const HIDDENPOSX = -80
var appear_pos_x : float

@export var shown = false

func _ready() -> void:
	appear_pos_x = position.x
	if !shown:
		position.x = HIDDENPOSX

func set_to_appear_pos():
	position.x = appear_pos_x

func appear():
	if !shown:
		shown = true
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position:x", appear_pos_x, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
		tween.play()
		print("hiiii")

func disappear():
	if shown:
		shown = false
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position:x", HIDDENPOSX, 0.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUART)
		tween.play()
