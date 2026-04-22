extends Control

const STARTER_ITEMS := [
	"Tennis Ball",
	"Old Collar Tag",
	"Street Snack",
]

@onready var close_button: Button = %CloseButton
@onready var item_list: ItemList = %ItemList
@onready var empty_label: Label = %EmptyLabel
@onready var pause_menu: Control = $"../PauseMenu"


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	close_button.pressed.connect(_close_menu)
	_refresh_items()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		if visible:
			_close_menu()
		elif not pause_menu.visible:
			_open_menu()
		get_viewport().set_input_as_handled()
		return

	if visible and event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_ESCAPE:
		_close_menu()
		get_viewport().set_input_as_handled()


func _open_menu() -> void:
	show()
	get_tree().paused = true
	close_button.grab_focus()


func _close_menu() -> void:
	hide()
	if not pause_menu.visible:
		get_tree().paused = false


func _refresh_items() -> void:
	item_list.clear()

	for item_name in STARTER_ITEMS:
		item_list.add_item(item_name)

	empty_label.visible = item_list.item_count == 0
	item_list.visible = item_list.item_count > 0
