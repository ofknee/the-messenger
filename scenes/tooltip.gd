extends PanelContainer
const OFFSET: Vector2 = Vector2.ONE * 10.0

func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if visible and event is InputEventMouseMotion:
		global_position = get_global_mouse_position() + OFFSET
	global_position.x = clamp(position.x, 0, 380)
func toggle(on: bool):
	if on:
		show()
	else:
		hide()
