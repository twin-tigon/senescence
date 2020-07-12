extends Node2D

func _input(_event):
	if Input.is_action_pressed('ui_accept'):
		Global.lives = 3
		Global.can_jump = true
		Global.can_run = true
		var levelScene = 'res://scenes/level_screen.tscn'
		if get_tree().change_scene(levelScene) != OK:
			print('error loading level scene')
