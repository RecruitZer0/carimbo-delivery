extends AnimationTree

@onready var player: Player = get_owner()
var move_looped := false

func _process(_delta: float) -> void:
	if player.input.dir_input:
		set("parameters/idle/blend_position", player.input.dir_input)
		set("parameters/move/blend_position", player.input.dir_input)


func _sprite_animation_started() -> void:
	if not player: return
	if player.sprite.animation.begins_with("move_"):
		move_looped = false

func _sprite_frame_changed() -> void:
	if not player: return
	if player.sprite.animation.begins_with("move_"):
		if player.sprite.frame == 2:
			move_looped = true
