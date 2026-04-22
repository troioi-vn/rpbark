extends Control

@onready var player := $"../../Player"
@onready var stamina_bar: ProgressBar = %StaminaBar


func _ready() -> void:
	stamina_bar.min_value = 0.0
	stamina_bar.max_value = player.max_stamina
	stamina_bar.value = player.stamina
	player.stamina_changed.connect(_on_player_stamina_changed)


func _on_player_stamina_changed(current: float, maximum: float) -> void:
	stamina_bar.max_value = maximum
	stamina_bar.value = current
