class_name PlayerInput extends Node

@onready var player: Player = get_owner()

var dir_input: Vector2

func _process(_delta: float) -> void:
	dir_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
