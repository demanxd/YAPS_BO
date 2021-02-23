class_name Actor
extends KinematicBody2D

# Both the Player and Enemy inherit this scene as they have shared behaviours
# such as speed and are affected by gravity.


export var speed = Vector2(150.0, 350.0)
export var run_md = 1.5
onready var is_run = false
onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
export var is_movable = false
export var mass = 1

const FLOOR_NORMAL = Vector2.UP

var _velocity = Vector2.ZERO

# _physics_process is called after the inherited _physics_process function.
# This allows the Player and Enemy scenes to be affected by gravity.
func _physics_process(delta):
	_velocity.y += gravity * delta

func speed_set(expr : float):
	speed = expr

func speed_get():
	return speed

