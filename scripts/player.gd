extends KinematicBody2D

const GRAVITY = 200
const RUN_FORCE = 800
const RUN_MAX_SPEED = 300
const WALK_FORCE = 300
const WALK_MAX_SPEED = 100
const STOP_FORCE = 1300
const JUMP_SPEED = 180
const SHOOT_SPEED = 150

var velocity = Vector2()
var next_scene

var sprite_run
var sprite_walk
var sprite_jump
var sprite_idle

# Called when the node enters the scene tree for the first time.
func _ready():
	match Global.level:
		2:
			sprite_run = $sprite_adult_run
			sprite_walk = $sprite_adult_walk
			sprite_jump = $sprite_adult_jump
			sprite_idle = $sprite_adult_run
		3:
			sprite_run = $sprite_old_run
			sprite_walk = $sprite_old_walk
			sprite_jump = $sprite_old_jump
			sprite_idle = $sprite_old_run
		_:
			sprite_run = $sprite_young_run
			sprite_walk = $sprite_young_walk
			sprite_jump = $sprite_young_jump
			sprite_idle = $sprite_young_run

func _physics_process(delta):
	_hide_all_sprites()
	var move_left = Input.is_action_pressed('ui_left')
	var move_right = Input.is_action_pressed('ui_right')
	var press_run = Global.can_run and Input.is_action_pressed('ui_shift')
	var press_jump = Global.can_jump and Input.is_action_pressed('ui_select')
	
	# Choose correct player sprite and orientation
	var sprite = sprite_idle
	if press_jump:
		sprite = sprite_jump
	elif press_run:
		sprite = sprite_run
	elif move_left or move_right:
		sprite = sprite_walk
		
	sprite.show()
	if move_left:
		sprite.set_flip_h(true)
	elif move_right:
		sprite.set_flip_h(false)
	
	## Run
	# Horizontal movement code. First, get the player's input.
	var force = WALK_FORCE
	var max_speed = WALK_MAX_SPEED
	if press_run:
		force = RUN_FORCE
		max_speed = RUN_MAX_SPEED
	var run = force * (-1 if move_left else (1 if move_right else 0))
	
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
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "shrine": # shrine
			_next_level()
			Global.level += 1
			if Global.level == 2:
				Global.can_run = false
			elif Global.level == 3:
				Global.can_jump = false
			else:
				_win()
			break
		elif collision.collider.name == "tree": # platform
			velocity.y = -SHOOT_SPEED
			break
			
	if sprite.global_position.y > get_viewport_rect().size.y:
		Global.lives -= 1
		if Global.lives <= 0:
			_game_over()
		else:
			_restart_level()
			
func _hide_all_sprites():
	$sprite_young_idle.hide()
	$sprite_young_jump.hide()
	$sprite_young_walk.hide()
	$sprite_young_run.hide()
	$sprite_adult_idle.hide()
	$sprite_adult_jump.hide()
	$sprite_adult_walk.hide()
	$sprite_adult_run.hide()
	$sprite_old_idle.hide()
	$sprite_old_jump.hide()
	$sprite_old_walk.hide()
	$sprite_old_run.hide()
	
func _game_over():
	get_tree().change_scene('res://scenes/game_over.tscn')

func _restart_level():
	get_tree().change_scene('res://scenes/level.tscn')

func _next_level():
	get_tree().change_scene('res://scenes/level_screen.tscn')

func _win():
	get_tree().change_scene('res://scenes/main.tscn')
