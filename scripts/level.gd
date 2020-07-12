extends Node2D

func _ready():
	match Global.level:
		1:
			modulate = Color(0.64, 0.46, 0.28, 1.0)
		2:
			modulate = Color(0.65, 0.77, 0.81, 1.0)
		_:
			modulate = Color(1.0, 1.0, 1.0, 1.0)