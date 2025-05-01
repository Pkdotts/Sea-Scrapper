extends Control

@export var increment_size = 32
@onready var container = $ScrapBarContainer
@onready var line = $ScrapBarContainer/ScrapBarLine
@onready var effects_player = $EffectsAnimation

func _ready() -> void:
	line.size.x = 0
	#line.hide()

func update_bar(time: float):
	var charge_amount = Global.get_charge()
	var step = increment_size/Global.persistPlayer.charge_step
	
	#line.show()
	var new_size = step * charge_amount + 2
	var tween = get_tree().create_tween()
	tween.tween_property(line, "size:x", new_size, time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	tween.play()
	effects_player.play("Flash")
	await tween.finished
	#if charge_amount <= 0:
		#line.hide()

func _on_effects_animation_animation_finished(anim_name: StringName) -> void:
	if Global.get_charge() >= Global.persistPlayer.charge_step:
		effects_player.play("Blinking")
