class_name Player extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite
@onready var collision: CollisionShape2D = $Collision
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var input: PlayerInput = $PlayerInput
@onready var stamp_offset: Marker2D = $StampOffset

var should_spend_ink: bool = true
var should_create_stamp: bool = true
var ink_cooldown: float = 0.0

@export var ink_amount: float = 100.0 :
	set(value):
		ink_amount = clamp(value, 0, 200)
@export_group("Upgrades")
@export var speed_multiplier: float = 1.0
@export var stamp_cost_multiplier: float = 1.0
@export var stamp_color: Color = Color.BLACK

signal stamp_check

const MOVE_SPEED = 96.0
const STAMP_BASE_COST = 10.0


func _physics_process(delta: float) -> void:
	ink_cooldown = move_toward(ink_cooldown, 0, delta)
	velocity = input.dir_input.normalized() * MOVE_SPEED * speed_multiplier
	var collided := move_and_slide()
	_post_move(delta, collided)


func _post_move(_delta: float, _collided: bool) -> void:
	should_spend_ink = true
	should_create_stamp = true
	emit_signal("stamp_check")
	
	if should_spend_ink and sprite.frame > 0:
		if should_create_stamp and ink_amount > 0:
			create_stamp()
			ink_amount -= stamp_cost()
		elif sprite.frame == 1 and ink_cooldown == 0:
			ink_amount -= stamp_cost()
			ink_cooldown = 0.4


func create_stamp() -> Stamp:
	var stamp := Stamp.new(self, stamp_offset.global_position, stamp_color)
	add_sibling(stamp)
	return stamp

func stamp_cost() -> float:
	return STAMP_BASE_COST * stamp_cost_multiplier
