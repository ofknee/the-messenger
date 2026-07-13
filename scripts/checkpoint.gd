extends Area2D
#on checkpoint entered
	#compare collision to previous collisions
	#if this collision coord higher, then do nothing
	#if this collision coord lower, tp to higher checkpoint

@onready var player = $"../../Player"
@onready var check_node = %checkpoints
#on checkpoint exited, set highest y to checkpoint pos
var change_save
var unlocked = Global.unlocked



func _on_body_entered(body: Node2D) -> void:
	if unlocked["checkpoints"] == true:
		print(self.position.y, self)
		_is_higher(self)
			
		
	
	#print(Global.high_check)

func _is_higher(node: Area2D):
	if unlocked["checkpoints"] == true:
		if node.position.y < Global.high_check:
			Global.high_check = node.position.y
			Global.high_checkpoint = node
			print('high_check: ') 
			print(Global.high_check)
			print('high_checkpoint: ') 
			print(Global.high_checkpoint)
		elif node.position.y > Global.high_check:
			#playposition = Global.high_checkpoint.position
			player.global_position.x = Global.high_checkpoint.global_position.x
			player.global_position.y = Global.high_checkpoint.global_position.y + 20


func _ready() -> void:
	check_node.visible = false
