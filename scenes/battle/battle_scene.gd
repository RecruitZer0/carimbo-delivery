extends Control

@onready var background: ColorRect = %Background
@onready var skill_check: Area2D = %SkillCheck

var direction: Vector2
var speed: float

func _process(_delta: float) -> void:
	var time_tick: float = Time.get_ticks_msec()/10000.0
	direction = Vector2.from_angle(sin(time_tick/10*PI) * cos(time_tick/5*PI) * PI).normalized()
	speed = cos(time_tick/6*PI) * 0.1
	background.material.set("shader_parameter/direction", direction)
	background.material.set("shader_parameter/speed", speed)
