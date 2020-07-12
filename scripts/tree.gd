extends KinematicBody2D

func animate():
	var sprite = get_node('animated_tree')
	sprite.play()
