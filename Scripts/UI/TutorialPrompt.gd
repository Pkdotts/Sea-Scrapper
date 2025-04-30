extends Container

@export var hidden_pos = Vector2(- 80, 0)
@export var hide_x = true
@export var hide_y = false
@export var tween_time = 0.5
@export var blink = false

var appear_pos: Vector2

@export var shown = false

func _ready() -> void:
	if blink and get_node_or_null("AnimationPlayer") != null:
		$AnimationPlayer.play("Blink")
	appear_pos.x = position.x
	appear_pos.y = position.y
	if !shown:
		if hide_x:
			position.x = hidden_pos.x
		if hide_y:
			position.y = hidden_pos.y

func set_to_appear_pos():
	
	position.x = appear_pos.x
	position.y = appear_pos.y

func appear():
	if !shown:
		shown = true
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position:x", appear_pos.x, tween_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
		tween.tween_property(self, "position:y", appear_pos.y, tween_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
		tween.play()
		print("hiiii")

func disappear():
	if shown:
		shown = false
		var tween = get_tree().create_tween()
		if hide_x:
			tween.tween_property(self, "position:x", hidden_pos.x, tween_time).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUART)
		if hide_y:
			tween.tween_property(self, "position:y", hidden_pos.y, tween_time).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUART)
		tween.play()
