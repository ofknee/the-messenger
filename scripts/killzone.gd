extends Area2D

@onready var timer = $Timer
@onready var start_pos = %startPos1
#@onready

func _on_body_entered(_body: Node2D) -> void:
	if _body.name == "Player":
		print("you died")
		#set_deferred("monitoring", false) 
		#Engine.time_scale = 0.5
		#timer.start()
		Global.coins = 0
		Global.dead = true
	



#func _on_timer_timeout() -> void:
	#Engine.time_scale = 1
#	Global.coins = 0
	#get_tree().reload_current_scene()
