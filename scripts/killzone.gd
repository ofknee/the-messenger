extends Area2D

@onready var timer = $Timer
@export var start_pos0 : Marker2D
@export var start_pos1 : Marker2D
@export var start_pos2 : Marker2D
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
