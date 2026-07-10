extends Area2D
@onready var anim = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@export var type : CoinType
var unlock_animation : bool = true
var unlock_sound : bool = false

func _ready() -> void:
	anim.sprite_frames = type.anim
	if unlock_animation:
		anim.play()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.coins += type.value
	#if Input.is_action_just_pressed("terror_mode"):
		#unlock_sound = true
	#if unlock_sound == true:
		animation_player.play("pickup")
	#else:
		#queue_free()
	print(Global.coins)
