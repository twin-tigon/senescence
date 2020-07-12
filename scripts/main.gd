extends Node2D

func _input(_event):
	if Input.is_action_pressed('ui_accept'):
		Global.level = 1
		var instructionsScene = 'res://scenes/instructions.tscn'
		if get_tree().change_scene(instructionsScene) != OK:
			print('error loading instructions scene')
