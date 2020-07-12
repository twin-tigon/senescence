extends Node2D

onready var tween = get_node("tween")

export var transition_duration = 1.00
export var transition_type = 1

func fade_out(stream_player):
	if stream_player == $_NULL:
		return

	tween.interpolate_property(stream_player, "volume_db", -12, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween.start()

func _on_tween_completed(object, _key):
	object.stop()
	Global.level = 1
	var instructionsScene = 'res://scenes/instructions.tscn'
	if get_tree().change_scene(instructionsScene) != OK:
		print('error loading instructions scene')

func _input(_event):
	if Input.is_action_pressed('ui_accept'):
		var audio = get_node('audio')
		fade_out(audio)
