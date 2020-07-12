extends Node2D

onready var tween1 = get_node("tween1")
onready var tween2 = get_node("tween2")
onready var tween3 = get_node("tween3")
onready var tween4 = get_node("tween4")
onready var tween5 = get_node("tween5")
onready var tweenContinue = get_node("tweenContinue")

var allowContinue = false

func _ready():
	tween1.interpolate_property($sentence1, "modulate:a", 0.0, 1.0, 6.0, 1, Tween.EASE_IN, 0)
	tween1.start()

func _on_tween1_tween_completed(_object, _key):
	tween2.interpolate_property($sentence2, "modulate:a", 0.0, 1.0, 4.0, 1, Tween.EASE_IN, 0)
	tween2.start()

func _on_tween2_tween_completed(_object, _key):
	tween3.interpolate_property($sentence3, "modulate:a", 0.0, 1.0, 4.0, 1, Tween.EASE_IN, 0)
	tween3.start()

func _on_tween3_tween_completed(_object, _key):
    tween4.interpolate_property($sentence4, "modulate:a", 0.0, 1.0, 4.0, 1, Tween.EASE_IN, 0)
    tween4.start()

func _on_tween4_tween_completed(_object, _key):
    tween5.interpolate_property($sentence5, "modulate:a", 0.0, 1.0, 4.0, 1, Tween.EASE_IN, 0)
    tween5.start()

func _on_tween5_tween_completed(_object, _key):
	tweenContinue.interpolate_property($enter, "modulate:a", 0.0, 1.0, 2.0, 1, Tween.EASE_IN, 0)
	tweenContinue.start()

func _on_tweenContinue_tween_completed(_object, _key):
	allowContinue = true

func _input(_event):
	if Input.is_action_pressed('ui_accept') and allowContinue:
		var levelScene = 'res://scenes/level_screen.tscn'
		if get_tree().change_scene(levelScene) != OK:
			print('error loading level scene')