extends Camera2D

@export var follow_player: bool = true

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player") as Player

func _process(_delta: float) -> void:
	if follow_player and player:
		global_position = player.global_position
