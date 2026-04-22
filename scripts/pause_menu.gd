extends Control

const SAVE_PATH := "user://savegame.cfg"

@onready var save_button: Button = %SaveButton
@onready var load_button: Button = %LoadButton
@onready var continue_button: Button = %ContinueButton
@onready var quit_button: Button = %QuitButton
@onready var status_label: Label = %StatusLabel
@onready var player := $"../../Player"
@onready var inventory_menu: Control = $"../InventoryMenu"


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	save_button.pressed.connect(_save_game)
	load_button.pressed.connect(_load_game)
	continue_button.pressed.connect(_close_menu)
	quit_button.pressed.connect(_quit_game)
	status_label.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_ESCAPE:
		if inventory_menu.visible:
			return

		if visible:
			_close_menu()
		else:
			_open_menu()
		get_viewport().set_input_as_handled()


func _open_menu() -> void:
	status_label.hide()
	show()
	get_tree().paused = true
	save_button.grab_focus()


func _close_menu() -> void:
	hide()
	get_tree().paused = false


func _save_game() -> void:
	var save_file := ConfigFile.new()
	save_file.set_value("player", "position_x", player.global_position.x)
	save_file.set_value("player", "position_y", player.global_position.y)
	save_file.set_value("player", "stamina", player.stamina)

	var error := save_file.save(SAVE_PATH)
	if error == OK:
		status_label.text = "Saved"
	else:
		status_label.text = "Save failed"

	status_label.show()
	save_button.grab_focus()


func _load_game() -> void:
	var save_file := ConfigFile.new()
	var error := save_file.load(SAVE_PATH)
	if error != OK:
		status_label.text = "No save found"
		status_label.show()
		load_button.grab_focus()
		return

	var position_x := save_file.get_value("player", "position_x", player.global_position.x) as float
	var position_y := save_file.get_value("player", "position_y", player.global_position.y) as float
	var stamina := save_file.get_value("player", "stamina", player.stamina) as float
	player.global_position = Vector2(position_x, position_y)
	player.velocity = Vector2.ZERO
	player.set_stamina(stamina)
	_close_menu()


func _quit_game() -> void:
	get_tree().quit()
