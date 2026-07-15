extends Area2D
@export var level_to_unlock : int
@onready var unlocked = Global.unlocked



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("door", level_to_unlock, "reached")
		if level_to_unlock == Global.Level.SPIKES:
			unlocked["level2"] = false
		elif level_to_unlock == Global.Level.ADVANCED:
			unlocked["level3"] = false
