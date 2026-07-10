extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -370.0

@onready var terrorMode = %terrorMode
@onready var flashlight = $flashlight
@onready var animated_sprite = $AnimatedSprite2D
var unlock_animation = false
var unlock_terror = false

func _physics_process(delta: float) -> void:
	# Add the gravity.

	if Input.is_action_just_pressed("terror_mode"):
		unlock_terror = true
	
	if unlock_terror == true:
		flashlight.visible = true
		terrorMode.visible = true
	

	if Input.is_action_just_pressed("dead"):
		if unlock_animation == false:
			unlock_animation = true
		else:
			unlock_animation = false

	if not is_on_floor():
		velocity += get_gravity() * delta
		if unlock_animation == true:
			animated_sprite.play("fall")
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if unlock_animation == true:
			animated_sprite.play("jump")
		
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("walk_l", "walk_r")
	if direction:
		velocity.x = direction * SPEED
		if unlock_animation == true:
			animated_sprite.play("run")
			if direction < 0:
				animated_sprite.flip_h = false
			if direction > 0:
				animated_sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if unlock_animation == true:
			animated_sprite.play("idle")
		#if unlock_animation == false:
			#animated_sprite.stop()

	move_and_slide()
