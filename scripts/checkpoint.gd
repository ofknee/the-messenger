extends Area2D
#on checkpoint entered
	#compare collision to previous collisions
	#if this collision coord higher, then do nothing
	#if this collision coord lower, tp to higher checkpoint

@onready var player = $"../../Player"
@onready var animated_sprite = $AnimatedSprite2D
@onready var check_node = %checkpoints
@onready var tp = $teleport
@onready var open = $door_open
#on checkpoint exited, set highest y to checkpoint pos
var change_save
var unlocked = Global.unlocked
var saved_doors : Array



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if Global.level >= 1:
			if unlocked.get("checkpoints"):
				print(self.position.y, self)
				_add_to_door_list(self)
				_is_higher(self)
					
		
	
	#print(Global.high_check)

func _is_higher(node: Area2D):
	if unlocked.get("checkpoints"):
		print("IT WAS UNLOCKEDDDDD")
		if node.position.y < Global.high_check:
			Global.high_check = node.position.y
			Global.high_checkpoint = node
			if unlocked["animation"] == true:
				animated_sprite.play("open")
				
			if unlocked["sfx"]:
				open.play()
		
		elif node.position.y > Global.high_check:
			#playposition = Global.high_checkpoint.position
			if unlocked["sfx"]:
				tp.play(0.6)
			#await get_tree().create_timer(0.8).timeout
			player.global_position.x = Global.high_checkpoint.global_position.x
			player.global_position.y = Global.high_checkpoint.global_position.y + 20

func _add_to_door_list(body):
	saved_doors.append(body)

func _ready() -> void:
	SignalBus.thing_bought.connect(open_doors)
	check_node.visible = true

func open_doors():
	if unlocked.get("animation"):
		for item in saved_doors:
			animated_sprite.play("open")
			saved_doors.erase(item)
