extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -370.0

@onready var terrorMode = %terrorMode
@onready var flashlight = $flashlight
@onready var animated_sprite = $AnimatedSprite2D
@onready var land = $land
@onready var death = $death
@export var start_pos0 : Marker2D
@export var start_pos1 : Marker2D
@export var start_pos2 : Marker2D
var unlocked = Global.unlocked
var was_on_floor := false
var landing := false


func _ready() -> void:
	animated_sprite.animation_finished.connect(_on_animation_finished)
	global_position = start_pos0.global_position
	SignalBus.level_up.connect(level_up)
	SignalBus.thing_bought.connect(level_up_precursor)

func _physics_process(delta: float) -> void:
	if Global.dead == true:
		if unlocked["sfx"]:
			death.play()
		global_position = start_pos1.global_position
		Global.dead = false

	if Input.is_action_just_pressed("terror_mode"):
		if unlocked["terrorMode"] == false:
			unlocked["terrorMode"] = true
		else:
			unlocked["terrorMode"] = false
			flashlight.visible = false
			terrorMode.visible = false
			
	if unlocked["terrorMode"]:
		flashlight.visible = true
		terrorMode.visible = true
		
	if Input.is_action_just_pressed("dead"):
		unlocked["animation"] = true
		print("animation unlocked")

	was_on_floor = is_on_floor()

	if not is_on_floor():
		velocity += get_gravity() * delta
		if unlocked["animation"] and not landing:
			if velocity.y < 0:
				animated_sprite.play("jump")
			else:
				animated_sprite.play("fall")

		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if unlocked["animation"]:
			animated_sprite.play("jump")
	var direction := Input.get_axis("walk_l", "walk_r")
	
	if direction:
		velocity.x = direction * SPEED
		
		if direction < 0:
			animated_sprite.flip_h = false
		if direction > 0:
			animated_sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	if not was_on_floor and is_on_floor():
		if unlocked["animation"]:
			landing = true
			animated_sprite.play("land")
		if unlocked["sfx"]:
			land.play()

	if is_on_floor() and not landing:
		if direction:
			if unlocked["animation"]:
				animated_sprite.play("run")
		else:
			if unlocked["animation"]:
				animated_sprite.play("idle")


func _on_animation_finished() -> void:
	if animated_sprite.animation == "land":
		landing = false
		
		
func level_up_precursor() -> void:
	if unlocked["level3"]:
		level_up(2)
	elif unlocked["level2"]:
		level_up(1)
	
func level_up(new_level : int) -> void:
	if new_level == Global.Level.SPIKES:
		global_position = start_pos1.global_position
	else:
		global_position = start_pos1.global_position
