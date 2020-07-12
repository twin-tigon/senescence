extends Node2D

onready var tween1 = get_node("tween1")
onready var tween2 = get_node("tween2")
onready var tweenEnd = get_node("tweenEnd")
onready var timer = get_node("timer")

var isEnd = false

func _ready():
	tween1.interpolate_property($sentence1, "modulate:a", 0.0, 1.0, 4.0, 1, Tween.EASE_IN, 0)
	tween1.start()

func _on_tween1_tween_completed(_object, _key):
	if isEnd:
		return

	tween2.interpolate_property($sentence2, "modulate:a", 0.0, 1.0, 4.0, 1, Tween.EASE_IN, 0)
	tween2.start()

func _on_tween2_tween_completed(_object, _key):
	if isEnd:
		return

	timer.start()

func _on_timer_timeout():
	isEnd = true
	timer.stop()

	tween1.interpolate_property($sentence1, "modulate:a", 1.0, 0.0, 2.0, 1, Tween.EASE_IN, 0)
	tween1.start()
	tween2.interpolate_property($sentence2, "modulate:a", 1.0, 0.0, 2.0, 1, Tween.EASE_IN, 0)
	tween2.start()

	tweenEnd.interpolate_property($end, "modulate:a", 0.0, 1.0, 6.0, 1, Tween.EASE_IN, 0)
	tweenEnd.start()