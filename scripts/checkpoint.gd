extends Area2D

@onready var checkpoint = $Area2D

#on checkpoint entered
	#compare collision to previous collisions
	#if this collision coord higher, then do nothing
	#if this collision coord lower, tp to higher checkpoint


#on checkpoint exited, set highest y to checkpoint pos

func _on_body_entered(body: Node2D) -> void:
	print(checkpoint.position)
