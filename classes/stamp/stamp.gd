class_name Stamp extends Area2D

var player: Player
var collision: CollisionShape2D
var color: Color
var touching_player: bool = false

const TEXTURE = preload("uid://couxq2vdebmcc")
const COLLISION_SHAPE = preload("uid://bt6ncc7hmk406")
const COLLISION_LAYER = 4
const COLLSION_MASK = 2

func _init(init_player: Player, init_position: Vector2, init_color: Color) -> void:
	player = init_player
	player.connect("stamp_check", stamp_check)
	global_position = init_position
	color = init_color
	connect("body_entered", _body_entered)
	connect("body_exited", _body_exited)
	collision_layer = COLLISION_LAYER
	collision_mask = COLLSION_MASK
	y_sort_enabled = true

func _enter_tree() -> void:
	collision = CollisionShape2D.new()
	collision.shape = COLLISION_SHAPE
	add_child(collision)

func stamp_check() -> void:
	if touching_player:
		player.should_spend_ink = false
		player.should_create_stamp = false

func _body_entered(body: Node2D) -> void:
	if body is Player:
		touching_player = true
func _body_exited(body: Node2D) -> void:
	if body is Player:
		touching_player = false

func _draw() -> void:
	draw_texture(TEXTURE, -COLLISION_SHAPE.size/2, color)
