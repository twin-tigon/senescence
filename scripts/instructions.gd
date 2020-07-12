extends Node2D

onready var tween = get_node("tween")

func fade_out():
	tween.interpolate_property(self, "modulate:v", 1.0, 0.0, 1.0, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()

func _on_tween_completed(_object, _key):
	Global.lives = 3
	Global.can_jump = true`
	Global.can_run = true
	var levelScene = 'res://scenes/level_screen.tscn'
	if get_tree().change_scene(levelScene) != OK:
		print('error loading level scene')

func _input(_event):
	if Input.is_action_pressed('ui_accept'):
		fade_out()
