extends KinematicBody2D

const GRAVITY = 200
const RUN_FORCE = 800
const RUN_MAX_SPEED = 300
const WALK_FORCE = 300
const WALK_MAX_SPEED = 100
const STOP_FORCE = 1300
const JUMP_SPEED = 180

var velocity = Vector2()
var can_jump = true
var can_run = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var move_left = Input.is_action_pressed('ui_left')
	var move_right = Input.is_action_pressed('ui_right')
	var press_run = can_run and Input.is_action_pressed('ui_shift')
	var press_jump = can_jump and Input.is_action_pressed('ui_select')
	
	# Choose correct player orientation
	if move_left:
		$sprite.play("run")
		$sprite.set_flip_h(false)
	elif move_right:
		$sprite.play("run")
		$sprite.set_flip_h(true)
	else:
		$sprite.stop()
	
	## Run
	# Horizontal movement code. First, get the player's input.
	var force = WALK_FORCE
	var max_speed = WALK_MAX_SPEED
	if press_run:
		force = RUN_FORCE
		max_speed = RUN_MAX_SPEED
	var run = force * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	# Slow down the player if they're not trying to move.
	if abs(run) < force * 0.2:
		# The velocity, slowed down a bit, and then reassigned.
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	else:
		velocity.x += run * delta
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -max_speed, max_speed)

	# Vertical movement code. Apply gravity.
	velocity.y += GRAVITY * delta

	## Jump
	# Check for jumping. is_on_floor() must be called after movement code.
	if is_on_floor() and press_jump :
		velocity.y = -JUMP_SPEED
	# Move based on the velocity and snap to the ground.
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
