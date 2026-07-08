extends Area2D
@onready var coins = Global.coins
@onready var anim = $AnimatedSprite2D
@export var type : CoinType
var unlock_animation : bool = false

func _ready() -> void:
	anim.sprite_frames = type.anim
	if unlock_animation:
		anim.play()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		coins += type.value
