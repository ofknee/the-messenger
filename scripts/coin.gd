extends Area2D
@onready var anim = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@export var type : CoinType
var unlocked = Global.unlocked

func _ready() -> void:
	anim.sprite_frames = type.anim
	
func _process(delta: float) -> void:
	if unlocked.get("animation") == true:
			anim.play()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if type.value < 5:
			Global.coins += type.value
		else:
			Global.coins += randi_range(5,8)
	if unlocked.get("sfx") == true:
		animation_player.play("pickup")
	else:
		queue_free()
	print(Global.coins)
