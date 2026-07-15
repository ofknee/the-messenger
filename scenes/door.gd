extends Area2D
@export var level_to_unlock : int
@onready var unlocked = Global.unlocked
@onready var anim = $AnimatedSprite2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("door", level_to_unlock, "reached")
		if anim.animation != "open":
			anim.play("open")
		if level_to_unlock == Global.Level.SPIKES:
			Global.unlocked["level2"] = false
			Global.unlocked["checkpoints"] = false
			print("Stuff added")
		elif level_to_unlock == Global.Level.ADVANCED:
			Global.unlocked["level3"] = false
		SignalBus.door_entered.emit()
		print(Global.unlocked.keys())

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("dead"):
		print("door", level_to_unlock, "reached")
		if level_to_unlock == Global.Level.SPIKES:
			unlocked["level3"] = false
		SignalBus.level_up.emit(Global.Level.SPIKES)
