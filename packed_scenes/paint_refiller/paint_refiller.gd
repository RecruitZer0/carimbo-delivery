extends Area2D

var player: Player
var refilling := false
var time_to_fill: float = 1.5

func _process(delta: float) -> void:
	if not player:
		player = get_tree().get_first_node_in_group("Player")
	if refilling:
		player.ink_amount = move_toward(player.ink_amount, 100, 100/time_to_fill * delta)

func _body_entered(body: Node2D) -> void:
	if body is Player:
		refilling = true
func _body_exited(body: Node2D) -> void:
	if body is Player:
		refilling = false
