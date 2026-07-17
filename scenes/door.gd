extends Area2D
@export var level_to_unlock : int
@onready var unlocked = Global.unlocked
@onready var anim = $AnimatedSprite2D
@onready var click_arrow = %click_arrow



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("door", level_to_unlock, "reached")
		click_arrow.show()
		if anim.animation != "open":
			anim.play("open")
		if level_to_unlock == Global.Level.SPIKES:
			unlocked["level2"] = false
			SignalBus.door_entered.emit()
		elif level_to_unlock == 2:
			await get_tree().create_timer(1.0).timeout
			get_tree().paused = true
			SignalBus.game_over.emit()
		
		

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("dead"):
		print("door", level_to_unlock, "reached")

		SignalBus.level_up.emit(Global.Level.SPIKES)
