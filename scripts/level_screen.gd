extends Node2D

func _ready():
	$titleContainer/titleLabel.text = "Level: " + str(Global.level)

func _input(_event):
	if Input.is_action_pressed('ui_accept'):
		var levelScene = 'res://scenes/level.tscn'
		if get_tree().change_scene(levelScene) != OK:
			print('error loading instructions scene')
