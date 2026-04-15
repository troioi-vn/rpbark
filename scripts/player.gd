extends CharacterBody2D

const RUN_SPEED := 240.0
const WALK_SPEED := RUN_SPEED * 0.5
const JUMP_VELOCITY := -420.0
const FLOOR_ACCELERATION := 1400.0
const FLOOR_DECELERATION := 1800.0
const WALK_ANIMATION := &"walk"
const RUN_ANIMATION := &"run"
const RUN_IDLE_ANIMATION := &"run_idle"
const JUMP_ANIMATION := &"jump"

@onready var dog_sprite: AnimatedSprite2D = $DogSprite

var gravity := ProjectSettings.get_setting("physics/2d/default_gravity") as float
var facing_sign := 1.0
var run_mode_enabled := false
var last_walk_frame := 0


func _ready() -> void:
	_update_animation()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_SHIFT:
		run_mode_enabled = not run_mode_enabled


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	var acceleration := FLOOR_ACCELERATION if direction != 0.0 else FLOOR_DECELERATION
	var move_speed := RUN_SPEED if run_mode_enabled else WALK_SPEED
	var target_speed := direction * move_speed

	velocity.x = move_toward(velocity.x, target_speed, acceleration * delta)

	move_and_slide()
	_update_facing(direction)
	_update_animation()


func _update_facing(direction: float) -> void:
	if direction > 0.0:
		facing_sign = 1.0
	elif direction < 0.0:
		facing_sign = -1.0

	dog_sprite.flip_h = facing_sign < 0.0


func _update_animation() -> void:
	_store_walk_frame()

	if not is_on_floor():
		if dog_sprite.animation != JUMP_ANIMATION:
			dog_sprite.play(JUMP_ANIMATION)
		return

	if absf(velocity.x) > 15.0:
		var ground_animation := RUN_ANIMATION if run_mode_enabled else WALK_ANIMATION
		if dog_sprite.animation != ground_animation or not dog_sprite.is_playing():
			dog_sprite.play(ground_animation)
		return

	if run_mode_enabled:
		_play_run_idle()
		return

	_hold_current_walk_frame()


func _store_walk_frame() -> void:
	if dog_sprite.animation == WALK_ANIMATION:
		last_walk_frame = dog_sprite.frame


func _play_run_idle() -> void:
	if dog_sprite.animation != RUN_IDLE_ANIMATION or not dog_sprite.is_playing():
		dog_sprite.play(RUN_IDLE_ANIMATION)


func _hold_current_walk_frame() -> void:
	if dog_sprite.animation != WALK_ANIMATION:
		dog_sprite.play(WALK_ANIMATION)
		dog_sprite.set_frame_and_progress(last_walk_frame, 0.0)

	dog_sprite.pause()
