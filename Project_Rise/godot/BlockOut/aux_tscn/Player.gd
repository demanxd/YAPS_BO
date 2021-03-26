class_name Player
extends Actor
#https://www.youtube.com/c/GameEndeavor/videos
#https://vk.com/wall-165072537_2325
#movement speed 12 units per second

const FLOOR_DETECT_DISTANCE = 20.0
export var MAX_JUMP_DISTANCE = 0
var JUMP_DISTANCE = 0 #jump upper position
var IN_AIR = false
var in_jump = false

export(String) var action_suffix = ""

onready var platform_detector = $PlatformDetector
onready var sprite = $Sprite
onready var camera = $Camera2D
onready var timer = $Timer


var max_h = 0.0 #delete!!!


func _ready():
	pass


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
#		if Input.get_action_strength("run"):
#			is_run = true
#		else:
#			is_run = false
		
		var direction = get_direction()
#		if debug:
#			print_debug(self.name + ": direction = " + String(direction))
		
		if direction.y == -1:
			is_jump_interrupted = true
		else:
			is_jump_interrupted = false
		
#		if debug:
#			print_debug(self.name + ": is_jump_interrupted = " + String(is_jump_interrupted))
		
		_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	
		var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO
#		var is_on_platform = platform_detector.is_colliding()
		var is_on_platform = is_on_floor()
#		if debug:
#			print_debug(self.name + ": is_on_platform = " + String(is_on_floor()))
		
#		if Input.is_action_just_pressed("jump" + action_suffix):
#			if self.is_on_floor():
#				if _velocity.y <= MAX_JUMP_DISTANCE:
#					_velocity.y -= speed.y * gravity
#		elif !self.is_on_floor():
#			_velocity.y += speed.y * gravity
#		else:
#			_velocity.y = 0
		jump()
#		_velocity.y += gravity
		
		if (_velocity.y >= max_h):
			max_h = _velocity.y
		
		if debug:
			print_debug(self.name + ": max_h = " + String(max_h))
		
		_velocity = move_and_slide(_velocity, Vector2.UP)
#		_velocity = move_and_slide_with_snap(
#			_velocity, snap_vector, FLOOR_NORMAL, not is_on_platform, 4, 0.9, false
#			)
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.has_method("collide_with"):
				collision.collider.collide_with(collision, self)


func jump() -> void:
	if self.is_on_floor() or in_jump:
		if Input.is_action_just_pressed("jump" + action_suffix):
			in_jump = true
		if _velocity.y >= -MAX_JUMP_DISTANCE and in_jump:
			_velocity.y -= speed.y * gravity
			if _velocity.y <= MAX_JUMP_DISTANCE:
				in_jump = false
	elif not self.is_on_floor() and not in_jump:
		_velocity.y += speed.y * gravity
	else:
		_velocity.y = 0


func get_direction():
	return Vector2(
		Input.get_action_strength("move_right" + action_suffix)
			- Input.get_action_strength("move_left" + action_suffix),
			-1
			if is_on_floor() and Input.is_action_just_pressed("jump" + action_suffix)
			else 0
	)


# This function calculates a new velocity whenever you need it.
# It allows you to interrupt jumps.
func calculate_move_velocity(
	linear_velocity,
	direction,
	speed,
	is_jump_interrupted
):
	var velocity = linear_velocity
	velocity.x = speed.x * direction.x
#	if direction.y != 0.0:
#		velocity.y = speed.y * direction.y
#	if is_jump_interrupted:
#		# Decrease the Y velocity by multiplying it, but don't set it to 0
#		# as to not be too abrupt.
#		velocity.y *= 0.4
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
