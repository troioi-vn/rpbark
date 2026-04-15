extends Node2D

@export var band_color := Color(0.29, 0.45, 0.38, 1.0)
@export var base_y := 500.0
@export var band_height := 120.0
@export var hill_width := 240.0
@export var hill_variation := 70.0
@export var width := 3200.0
@export var floor_y := 720.0


func _draw() -> void:
	var points := PackedVector2Array()
	points.append(Vector2(0.0, floor_y))
	points.append(Vector2(0.0, base_y))

	var x := 0.0
	var hill_index := 0
	while x <= width:
		var crest_y := base_y - band_height - (hill_variation if hill_index % 2 == 0 else 0.0)
		points.append(Vector2(x + hill_width * 0.5, crest_y))
		points.append(Vector2(min(x + hill_width, width), base_y))

		x += hill_width
		hill_index += 1

	points.append(Vector2(width, floor_y))
	draw_colored_polygon(points, band_color)
