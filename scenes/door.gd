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
			unlocked["level2"] = false
			SignalBus.door_entered.emit()
		elif level_to_unlock == 3:
			SignalBus.game_over.emit()
		
		

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("dead"):
		print("door", level_to_unlock, "reached")

		SignalBus.level_up.emit(Global.Level.SPIKES)
