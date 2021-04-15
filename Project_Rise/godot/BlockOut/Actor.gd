class_name Actor
extends KinematicBody2D

# Both the Player and Enemy inherit this scene as they have shared behaviours
# such as speed and are affected by gravity.


export var speed_base = Vector2(216.0, 250.0)
export var is_moveble = false
export var is_under_gravity = false
export var mass = 1
export var local_speed_md = 1.0
export var debug = false
export var jump_height = 100
onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
onready var speed = Vector2.ZERO
export var local_direction = Vector2.ZERO
onready var local_MJD



const FLOOR_NORMAL = Vector2.UP

var _velocity = Vector2(0.0,0.0)

func _ready():
	speed.x = local_speed_md * speed_base.x
	speed.y = speed_base.y
	local_MJD = jump_height * gravity
	if debug:
		print_debug(self.name + " speed = " + String(speed) + "  Actor class")

# _physics_process is called after the inherited _physics_process function.
# This allows the Player and Enemy scenes to be affected by gravity.
#func _physics_process(delta):
#	if is_jump_interrupted:
#		_velocity.y += gravity * delta
#	if debug:
#		print_debug(self.name + " speed x = " + String(_velocity.x) + "; speed y = " + String(_velocity.y))

func speed_set(expr : Vector2):
	speed = expr

func speed_get():
	return speed

func set_local_speed_md(modificator : float):
	local_speed_md = modificator
	speed.x = local_speed_md * speed_base.x

func npc_move_and_slide_to(next_position : Vector2):
	var velocity = _velocity
	if(self.position.x < next_position.x):
		velocity.x = speed.x
	elif(self.position.x > next_position.x):
		velocity.x = -speed.x
	
	if(self.position.x < next_position.x):
		local_direction = Vector2.RIGHT
	elif(self.position.x > next_position.x):
		local_direction = Vector2.LEFT
	
	velocity = move_and_slide(velocity, FLOOR_NORMAL)


func add_gravity():
		_velocity.y += pow(gravity,2)
