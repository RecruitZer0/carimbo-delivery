extends TileMapLayer

var player: Player

const INK_BEHAVIOUR = "Ink Behaviour"

func _process(_delta: float) -> void:
	if not player:
		player = get_tree().get_first_node_in_group("Player")
		if player:
			player.connect("stamp_check", stamp_check)


func stamp_check() -> void:
	var tile_data := get_cell_tile_data(local_to_map(player.global_position - global_position - Vector2(0, 8)))
	var behaviour: int = tile_data.get_custom_data(INK_BEHAVIOUR)
	if behaviour & 0b01:
		player.should_spend_ink = false
	if behaviour & 0b10:
		player.should_create_stamp = false
