extends Node2D

onready var sepia = get_node("sepia-filter")
func _ready():
	match Global.level:
		1:
			sepia.visible = true
		2:
			modulate = Color(0.65, 0.77, 0.81, 1.0)
			sepia.visible = false
		_:
			modulate = Color(1.0, 1.0, 1.0, 1.0)
			sepia.visible = false
