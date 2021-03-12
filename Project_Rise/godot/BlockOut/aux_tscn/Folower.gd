class_name Folower
extends Walker


enum{
	IDLE,
	WANDER,
	CHASE
}

const FLOOR_DETECT_DISTANCE = 20.0
export var MAX_JUMP_DISTANCE = 0
var JUMP_DISTANCE = 0 #jump upper position
var IN_AIR = false

export var ACCELERATION = 300
export var MAX_SPEED    = 50
export var FRICTION     = 200 
export var WANDER_TARGET_RANGE = 4

var velocity = Vector2.ZERO

var state = CHASE

var knockback = Vector2.ZERO

#onready var sprite = $Sprite
#onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
#onready var hurtBox = $Hurtbox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
#onready var animationPlayer = $AnimationPlayer

#func _ready():
#	state = pick_random_state([IDLE, WANDER])


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
#
			if wanderController.get_time_left() == 0:
				update_wander()
#			pass
			
		WANDER:
#			seek_player()
#			if wanderController.get_time_left() == 0:
#				update_wander()
#
#			accelerate_towards_point(wanderController.target_position, delta)
#
#			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
#				update_wander()
			pass
		
		CHASE:
#			var player = playerDetectionZone.player
#			if player != null:
#				accelerate_towards_point(player.global_position, delta)
#			else:
#				state = IDLE
			pass
			
	
#	if softCollision.is_colliding():
#		velocity += softCollision.get_push_vector() * delta * 400
	calculate_move_velocity(velocity)#,wanderController.target_position,Vector2.RIGHT,false)
	
	var direction = Vector2.RIGHT
	
	var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO
	var is_on_platform = is_on_floor()
	
	_velocity = move_and_slide_with_snap(
		_velocity, snap_vector, FLOOR_NORMAL, not is_on_platform, 4, 0.9, false
		)


#func calculate_move_velocity(linear_velocity,direction,speed,is_jump_interrupted):
#	var velocity = linear_velocity
#	velocity.x = speed.x * direction.x
#	if direction.y != 0.0:
#		velocity.y = speed.y * direction.y
#	if is_jump_interrupted:
#		# Decrease the Y velocity by multiplying it, but don't set it to 0
#		# as to not be too abrupt.
#		velocity.y *= 0.4
#	return velocity



func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(MAX_SPEED * direction, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE


func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1,3))


func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

#
#func _on_Hurtbox_area_entered(area):
#	stats.health -= area.damage
#	knockback = area.knockback_vector * 100
#	hurtBox.create_hit_effect()
#	hurtBox.start_invincibility(0.4)
#
#
#func _on_Stats_no_health():
#	queue_free()
#	var enemyDeathEffect = EnemyDeathEffect.instance()
#	get_parent().add_child(enemyDeathEffect)
#	enemyDeathEffect.global_position = global_position
#
#
#func _on_Hurtbox_invincibility_started():
#	animationPlayer.play("Start")
#
#
#func _on_Hurtbox_invincibility_ended():
#	animationPlayer.play("Stop")


func _on_PlayerDetectionZone_body_entered(body):
	pass # Replace with function body.


func _on_PlayerDetectionZone_body_exited(body):
	pass # Replace with function body.
