extends Area2D

var check_radius: float = 0.0
var shrink_speed: float = 0.0
var clicked: bool = false

enum {DODGE, ATTACK}

const TEXTURES: Array[Array] = [[preload("uid://2ma1gejviq4s"), Color.AQUA], [preload("uid://c8isb6mw72jrr"), Color.RED]]
const BASE_POSITION = Vector2(320, 120)
const MAXIMUM_OFFSET = Vector2(120, 60)
const BASE_RADIUS = 128.0
const BASE_SPEED = 32

signal checked(type: StringName, radius: float)

var texture_idx: int = DODGE
var texture: Array :
	get():
		return TEXTURES[texture_idx]
	set(_value):
		pass

func appear(type: int, difficulty: float = 1.0) -> void:
	texture_idx = type
	difficulty = difficulty + randf_range(-0.5, 0.5)
	difficulty = maxf(difficulty, 0.5)
	var difficulty_root: float = sqrt(difficulty)
	global_position = BASE_POSITION + Vector2(randf_range(-difficulty**2, difficulty**2) * 10, randf_range(-difficulty**2, difficulty**2) * 5).clamp(-MAXIMUM_OFFSET, MAXIMUM_OFFSET)
	check_radius = BASE_RADIUS / difficulty_root
	shrink_speed = BASE_SPEED * difficulty
	clicked = false
	visible = true

func _process(delta: float) -> void:
	check_radius = move_toward(check_radius, 0, delta*shrink_speed)
	if check_radius <= 10 and visible:
		trigger()
	if Input.is_action_just_pressed("ui_accept"):
		appear(randi() % 2, 3)
	queue_redraw()

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		trigger()

func trigger() -> void:
	if clicked: return
	clicked = true
	shrink_speed = 0
	emit_signal("checked", texture_idx, check_radius)
	var tween := create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "rotation", PI/5, 0.15)
	tween.tween_property(self, "rotation", 0, 0.15)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.15)
	tween.tween_property(self, "visible", false, 0)
	tween.tween_property(self, "scale", Vector2.ONE, 0)

func _draw() -> void:
	draw_texture(texture[0], -texture[0].get_size()/2.0 + Vector2(2, 2), Color(0, 0, 0, 0.45))
	draw_texture(texture[0], -texture[0].get_size()/2.0)
	draw_circle(Vector2.ZERO, texture[0].get_height()/2.0, texture[1], false, 2, false)
	draw_circle(Vector2.ZERO, check_radius, Color.WHITE, false, 1, false)
