extends KinematicBody2D

var initialPosition = position
var positionRange = 50
var speed = 1

func _physics_process(_delta):
	var velocity = Vector2()

	if position.x > initialPosition.x + positionRange or position.x < initialPosition.x - positionRange:
		speed *= -1

	velocity.x += speed
	velocity = move_and_collide(velocity)
