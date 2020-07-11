extends KinematicBody2D

const GRAVITY = 200.0
const TOP_RUN_SPEED = 200.0
const START_RUN_ACCEL = 2.0
const END_RUN_ACCEL = 3.0

var horizontal_velocity = Vector2()
var vertical_velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		horizontal_velocity.x = -TOP_RUN_SPEED
	elif Input.is_action_pressed("ui_right"):
		horizontal_velocity.x =  TOP_RUN_SPEED
	else:
		horizontal_velocity.x = 0

	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
	move_and_slide(horizontal_velocity, Vector2(0, -1))
