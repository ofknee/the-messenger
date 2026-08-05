extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -370.0

@onready var terrorMode = %terrorMode
@onready var flashlight = $flashlight
@onready var animated_sprite = $AnimatedSprite2D
@onready var land = $land
@onready var death = $death
@onready var click_arrow = %click_arrow
@onready var level_arrow = $"../UI/Control/MarginContainer/Shop/level_arrow"
@onready var fall_particles = $FallImpactParticles/CPUParticles2D
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
	click_arrow.hide()
	level_arrow.hide()

func _physics_process(delta: float) -> void:
	if Global.dead == true:
		if unlocked.get("sfx"):
			death.play()
		global_position = start_pos1.global_position
		Global.dead = false
	if Input.is_action_just_pressed("quick_level"):
		global_position = start_pos1.global_position
		
	if Input.is_action_just_pressed("terror_mode"):
		if unlocked.get("terrorMode") == false:
			unlocked["terrorMode"] = true
		else:
			unlocked["terrorMode"] = false
			flashlight.visible = false
			terrorMode.visible = false
			
	if unlocked.get("terrorMode"):
		flashlight.visible = true
		terrorMode.visible = true
		
	if Input.is_action_just_pressed("dead"):
		if unlocked.get("animation") :
			unlocked["animation"] = true
		print("animation unlocked")

	was_on_floor = is_on_floor()

	if not is_on_floor():
		velocity += get_gravity() * delta
		if unlocked.get("animation") and not landing:
			if velocity.y < 0:
				animated_sprite.play("jump")
			else:
				animated_sprite.play("fall")

		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if unlocked.get("animation"):
			animated_sprite.play("jump")
	var direction := Input.get_axis("walk_l", "walk_r")
	
	if direction:
		velocity.x = direction * SPEED
		if unlocked.get("animation"):
			if direction < 0:
				animated_sprite.flip_h = false
			if direction > 0:
				animated_sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	if not was_on_floor and is_on_floor():
		if unlocked.get("animation"):
			landing = true
			animated_sprite.play("land")
		if unlocked.get("sfx"):
			land.play()
		#if unlocked.get("particles"):
		fall_particles.emitting = true

	if is_on_floor() and not landing:
		if direction:
			if unlocked.get("animation"):
				animated_sprite.play("run")
		else:
			if unlocked.get("animation"):
				animated_sprite.play("idle")


func _on_animation_finished() -> void:
	if animated_sprite.animation == "land":
		landing = false
		
		
func level_up_precursor() -> void:
	if Global.level == Global.Level.BASIC:
		if unlocked.get("level2"):
			Global.unlocked["checkpoints"] = false
			Global.unlocked["terrorMode"] = false
			unlocked = Global.unlocked
			print("unlocked" , unlocked)
			level_up(1)
			SignalBus.level_up.emit(1)
		

		
func level_up(new_level : int) -> void:
	Global.level = new_level
	if new_level == Global.Level.SPIKES:
		global_position = start_pos1.global_position
	else:
		global_position = start_pos1.global_position
