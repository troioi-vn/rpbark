extends Node2D

const LIFETIME := 1.26
const START_RADIUS := 10.0
const MAX_RADIUS := 940.0
const RING_THICKNESS := 70.0
const DISTORTION_STRENGTH := 11.0
const FADE_POWER := 1.7

@onready var wave_rect: ColorRect = $WaveRect
@onready var shader_material := wave_rect.material as ShaderMaterial

var age := 0.0


func _ready() -> void:
	z_index = 20
	wave_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	wave_rect.position = Vector2(-MAX_RADIUS, -MAX_RADIUS)
	wave_rect.size = Vector2(MAX_RADIUS * 2.0, MAX_RADIUS * 2.0)
	_update_shader(0.0)


func _process(delta: float) -> void:
	age += delta
	var progress := clampf(age / LIFETIME, 0.0, 1.0)
	_update_shader(progress)

	if progress >= 1.0:
		queue_free()


func _update_shader(progress: float) -> void:
	if shader_material == null:
		return

	var eased_progress := 1.0 - pow(1.0 - progress, 3.0)
	var radius := lerpf(START_RADIUS, MAX_RADIUS, eased_progress)
	var fade := pow(1.0 - progress, FADE_POWER)

	shader_material.set_shader_parameter("rect_size_px", wave_rect.size)
	shader_material.set_shader_parameter("radius_px", radius)
	shader_material.set_shader_parameter("ring_thickness_px", RING_THICKNESS)
	shader_material.set_shader_parameter("distortion_strength_px", DISTORTION_STRENGTH * fade)
	shader_material.set_shader_parameter("alpha", fade)
