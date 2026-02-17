extends AnimationTree

@onready var player: Player = get_owner()
var move_looped := false

func _process(_delta: float) -> void:
	if player.input.dir_input:
		set("parameters/idle/blend_position", player.input.dir_input)
		set("parameters/move/blend_position", player.input.dir_input)
