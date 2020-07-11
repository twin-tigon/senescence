extends Node2D

func _input(_event):
	if Input.is_action_pressed('ui_accept'):
		var instructionsScene = 'res://scenes/instructions.tscn'
		get_tree().change_scene(instructionsScene)