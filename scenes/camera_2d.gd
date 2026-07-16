extends Camera2D

@onready var unlocked = Global.unlocked

func _ready() -> void:
	#camera baddddddd
	position_smoothing_enabled = false
	SignalBus.thing_bought.connect(enable_nice_camera)
	drag_vertical_offset = 0.0
	zoom = Vector2(2,2)

func enable_nice_camera(): # yes smoothing is better
	if unlocked.get("camera"):
		position_smoothing_enabled = true
		drag_horizontal_enabled = true
		drag_vertical_offset = -0.66
		zoom = Vector2(1.7,1.7)
