extends Node

signal after_image_created

@onready var AfterImage = preload("res://Nodes/Effects/After Image.tscn")
#@onready var timer = $Timer

@export var spritePath : NodePath
@export var generateTime = 0.01
@onready var sprite = get_node_or_null(spritePath)

var creating = false

var timer = 0

func create_after_image() -> void: #use sprite.duplicate()
	var after_image = AfterImage.instantiate()
	var new_sprite = sprite.duplicate(DUPLICATE_USE_INSTANTIATION)
	after_image.set_new_texture(new_sprite)
	after_image.global_position = sprite.global_position
	get_parent().get_parent().add_child(after_image)
	emit_signal("after_image_created")

func _physics_process(delta: float) -> void:
	if creating:
		timer += delta
		if (timer >= generateTime):
			timer = 0 
			create_after_image()

func set_interval(time) -> void:
	generateTime = time

func start_creating() -> void:
	timer = 0
	creating = true

func stop_creating() -> void:
	creating = false
