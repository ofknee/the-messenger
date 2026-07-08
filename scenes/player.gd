extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450.0

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite.play("fall")
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump")
		
	if Input.is_action_just_pressed("die"):
		animated_sprite.play("die")
		
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("walk_l", "walk_r")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.play("run")
		if direction < 0:
			animated_sprite.flip_h = false
		if direction > 0:
			animated_sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")

	move_and_slide()
