class_name Player
extends Actor
#https://www.youtube.com/c/GameEndeavor/videos
#https://vk.com/wall-165072537_2325
#movement speed 12 units per second

const FLOOR_DETECT_DISTANCE = 20.0
export var MAX_JUMP_DISTANCE = 0
export var local_gravity = 1 #delete later
var in_jump = false
onready var local_MJD

export(String) var action_suffix = ""

onready var platform_detector = $PlatformDetector
onready var sprite = $Sprite
onready var camera = $Camera2D
onready var timer = $Timer


var max_h = 0.0 #delete!!!


func _ready():
	local_MJD = jump_height * gravity
#	pass


# Physics process is a built-in loop in Godot.
# If you define _physics_process on a node, Godot will call it every frame.

# We use separate functions to calculate the direction and velocity to make this one easier to read.
# At a glance, you can see that the physics process loop:
# 1. Calculates the move direction.
# 2. Calculates the move velocity.
# 3. Moves the character.
# 4. Updates the sprite direction.
# 5. Shoots bullets.
# 6. Updates the animation.

# Splitting the physics process logic into functions not only makes it
# easier to read, it help to change or improve the code later on:
# - If you need to change a calculation, you can use Go To -> Function
#   (Ctrl Alt F) to quickly jump to the corresponding function.
# - If you split the character into a state machine or more advanced pattern,
#   you can easily move individual functions.
func _physics_process(_delta):
	
	if is_moveble:
		
		var direction = get_direction()
		
		_velocity = calculate_move_velocity(_velocity, direction, speed)
	
#		var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO
		var is_on_platform = is_on_floor()
#		jump(true) #if direction.y == 1 else false)
		
		_velocity.y += pow(gravity,2)
		
		if (direction.y):
			_velocity.y -= local_MJD
		
		if (-_velocity.y >= max_h):
			max_h = -_velocity.y
		
		if debug:
			print(self.name + ": velocity y = " + String(-_velocity.y))
#			if direction.y == 1:
#				print(String(direction.x) + "; " + String(direction.y))

		_velocity = move_and_slide(_velocity, Vector2.UP)
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.has_method("collide_with"):
				collision.collider.collide_with(collision, self)


func jump(dir_y) -> void:
#	if self.is_on_floor() or in_jump:
#	if dir_y:#Input.is_action_just_pressed("jump" + action_suffix):
#		in_jump = true
#		_velocity.y -= speed.y
#	if _velocity.y >= -MAX_JUMP_DISTANCE and in_jump:
#		_velocity.y -= _velocity.y * gravity
#		if _velocity.y <= -MAX_JUMP_DISTANCE:
#			in_jump = false
#	elif not in_jump:
#		_velocity.y += _velocity.y * gravity
#	else:
#		_velocity.y = 0
	_velocity.y += MAX_JUMP_DISTANCE


func get_direction():
	return Vector2(
		Input.get_action_strength("move_right" + action_suffix)
			- Input.get_action_strength("move_left" + action_suffix),
			1
			if self.is_on_floor() and Input.is_action_just_pressed("jump" + action_suffix)
			else 0
	)


# This function calculates a new velocity whenever you need it.
# It allows you to interrupt jumps.
func calculate_move_velocity(
	linear_velocity,
	direction,
	speed
):
	var velocity = linear_velocity
	velocity.x = speed.x * direction.x
#	if direction.y != 0.0:
#		velocity.y = speed.y * direction.y
#	if is_jump_interrupted:
#		# Decrease the Y velocity by multiplying it, but don't set it to 0
#		# as to not be too abrupt.
#		velocity.y *= 0.4
#	if direction.y:
#		in_jump = true
#	if in_jump:
#		if _velocity.y >= -MAX_JUMP_DISTANCE and in_jump:
#			_velocity.y -= speed.y * gravity
#			if _velocity.y <= -MAX_JUMP_DISTANCE:
#				in_jump = false
#	elif not in_jump:
#		_velocity.y += speed.y * gravity
#	else:
#		_velocity.y = 0
	
	return velocity


func get_new_animation(is_shooting = false):
	var animation_new = ""
	if is_on_floor():
		animation_new = "run" if abs(_velocity.x) > 0.1 else "idle"
	else:
		animation_new = "falling" if _velocity.y > 0 else "jumping"
	return animation_new

func set_camera_limits(x_left, x_right, y_top, y_bottom):
	camera.limit_top    = y_top
	camera.limit_left   = x_left
	camera.limit_right  = x_right + 2000
	camera.limit_bottom = y_bottom


func immediatly_move(new_position: Vector2, waiting_time: float):
	self.position = new_position
	is_moveble = false
	timer.start(waiting_time)
	


func _on_Timer_timeout():
	if !is_moveble:
		is_moveble = true
	
	pass # Replace with function body.
