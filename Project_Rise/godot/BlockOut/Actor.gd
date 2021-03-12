class_name Actor
extends KinematicBody2D

# Both the Player and Enemy inherit this scene as they have shared behaviours
# such as speed and are affected by gravity.


export var speed_base = Vector2(150.0, 350.0)
export var is_moveble = false
export var mass = 1
export var local_speed_md = 1.0
onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
onready var speed = Vector2.ZERO


const FLOOR_NORMAL = Vector2.UP

var _velocity = Vector2.ZERO

func _ready():
	speed.x = local_speed_md * speed_base.x
	speed.y = speed_base.y
	print_debug(speed)

# _physics_process is called after the inherited _physics_process function.
# This allows the Player and Enemy scenes to be affected by gravity.
func _physics_process(delta):
	_velocity.y += gravity * delta

func speed_set(expr : Vector2):
	speed = expr

func speed_get():
	return speed

func set_local_speed_md(modificator : float):
	local_speed_md = modificator
	speed.x = local_speed_md * speed_base.x
