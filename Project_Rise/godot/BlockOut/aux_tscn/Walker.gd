class_name Walker
extends Actor




  
"""Moving platform, moves to target positions given by the Waypoints node"""
#tool

onready var wait_timer: Timer = $Timer
onready var platform_detector: RayCast2D = $Platform_Detector
onready var left_p_detect : CollisionShape2D = $Left_Player_Detector/Collision
onready var right_p_detect : CollisionShape2D = $Right_Player_Detector/Collision

onready var waypoints

export var editor_process: = true setget set_editor_process
export var waypoints_path: = NodePath()
export var wait_time : = 1.0

onready var last_local_direction: Vector2

var target_position: = Vector2()

func _ready() -> void:
	waypoints = get_node(waypoints_path)
	last_local_direction = local_direction
	if waypoints:
		position = waypoints.get_start_position()
		target_position = waypoints.get_next_point_position()
	_extends_phys_process()
	

func _physics_process(delta: float) -> void:
#	if debug:
#		if !platform_detector.collide_with_bodies:
#			print_debug("Warning! " + self.name + " cannot collide with bodies!")
	if is_moveble:
		if (self.position.x != target_position.x):
			npc_move_and_slide_to(target_position)
		
		""" Set a maximum delta between current and next points. 
		When metrics would done, this *if* wouldn,t be necessary """
		
		if (abs(self.position.x - target_position.x)) <= 4:
			if debug:
				print_debug(self.name + ": getting a new point")
			target_position = waypoints.get_next_point_position()
			if debug:
				print(self.name + ": next point: " + String(target_position))
		if (last_local_direction != local_direction):
			if (local_direction == Vector2.RIGHT):
				if left_p_detect.is_processing():
					left_p_detect.set_process(false)
				if not right_p_detect.is_processing():
					right_p_detect.set_process(true)
			else:
				if right_p_detect.is_processing():
					right_p_detect.set_process(false)
				if not left_p_detect.is_processing():
					left_p_detect.set_process(true)
	if is_under_gravity:
		if not is_on_floor():
			add_gravity()
			if debug:
				print(self.name + ": _velocity = " + String(_velocity))
		elif self._velocity.y != 0:
			_velocity.y -= local_MJD


func set_editor_process(value:bool) -> void:
	editor_process = value
	if not Engine.editor_hint:
		return
	set_physics_process(value)


func _on_Timer_timeout() -> void:
	set_physics_process(true)


func _on_Left_Player_Detector_body_entered(body):
	if debug:
		print_debug(self.name + ": " + body.name + " is cached in left!")
	left_trigger_process()


func _on_Right_Player_Detector_body_entered(body):
	if debug:
		print_debug(self.name + ": " + body.name + " is cached in right!")
	right_trigger_process()



func left_trigger_process():
	pass

func right_trigger_process():
	pass


func _extends_phys_process():
	print(self.name + ": extends phys process")





















"""
Good for using without waypoints

enum State {
	WALKING,
	DEAD
}

var _state = State.WALKING

onready var platform_detector = $Platform_Detector
onready var floor_detector_left = $Floor_Detector_Left
onready var floor_detector_right = $Floor_Detector_Right
onready var whall_detector_left = $Whall_Detector_Left
onready var whall_detector_right = $Whall_Detector_Right
onready var sprite = $Sprite
#onready var animation_player = $AnimationPlayer

# This function is called when the scene enters the scene tree.
# We can initialize variables here.
func _ready():
	_velocity.x = speed.x

# Physics process is a built-in loop in Godot.
# If you define _physics_process on a node, Godot will call it every frame.

# At a glance, you can see that the physics process loop:
# 1. Calculates the move velocity.
# 2. Moves the character.
# 3. Updates the sprite direction.
# 4. Updates the animation.

# Splitting the physics process logic into functions not only makes it
# easier to read, it help to change or improve the code later on:
# - If you need to change a calculation, you can use Go To -> Function
#   (Ctrl Alt F) to quickly jump to the corresponding function.
# - If you split the character into a state machine or more advanced pattern,
#   you can easily move individual functions.
func _physics_process(_delta):
	_velocity = calculate_move_velocity(_velocity)

	# We only update the y value of _velocity as we want to handle the horizontal movement ourselves.
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y






# This function calculates a new velocity whenever you need it.
# If the enemy encounters a wall or an edge, the horizontal velocity is flipped.
func calculate_move_velocity(linear_velocity):
	var velocity = linear_velocity

	if not floor_detector_left.is_colliding():
		velocity.x = speed.x
	elif not floor_detector_right.is_colliding():
		velocity.x = -speed.x

	if is_on_wall():
		velocity.x *= -1

	return velocity


func destroy():
#	_state = State.DEAD
	_velocity = Vector2.ZERO


#func get_new_animation():
#	var animation_new = ""
#	if _state == State.WALKING:
#		animation_new = "walk" if abs(_velocity.x) > 0 else "idle"
#	else:
#		animation_new = "destroy"
#	return animation_new
"""

