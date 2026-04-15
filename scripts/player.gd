extends CharacterBody2D

const SPEED := 240.0
const JUMP_VELOCITY := -420.0
const FLOOR_ACCELERATION := 1400.0
const FLOOR_DECELERATION := 1800.0

@onready var dog_sprite: AnimatedSprite2D = $DogSprite

var gravity := ProjectSettings.get_setting("physics/2d/default_gravity") as float
var facing := "right"


func _ready() -> void:
	_update_animation()


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	var acceleration := FLOOR_ACCELERATION if direction != 0.0 else FLOOR_DECELERATION
	var target_speed := direction * SPEED

	velocity.x = move_toward(velocity.x, target_speed, acceleration * delta)

	move_and_slide()
	_update_facing(direction)
	_update_animation()


func _update_facing(direction: float) -> void:
	if direction > 0.0:
		facing = "right"
	elif direction < 0.0:
		facing = "left"


func _update_animation() -> void:
	var state := "idle"
	if not is_on_floor():
		state = "jump"
	elif absf(velocity.x) > 15.0:
		state = "run"

	dog_sprite.play("%s_%s" % [state, facing])
