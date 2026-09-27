extends CanvasLayer

@onready var coin_label: Label = $HUD/CoinLabel
@onready var health_bar: ProgressBar = $HUD/HealthBar
@onready var pause_overlay: Control = $PauseMenu
@onready var resume_btn: Button = $PauseMenu/ResumeButton

var is_paused: bool = false

func _ready() -> void:
	_setup_ui_bindings()
	_connect_game_signals()

func _setup_ui_bindings() -> void:
	if pause_overlay:
		pause_overlay.visible = false
	if resume_btn and not resume_btn.pressed.is_connected(_on_resume_pressed):
		resume_btn.pressed.connect(_on_resume_pressed)

func _connect_game_signals() -> void:
	var manager = get_node_or_null("/root/Manager")
	if manager:
		if manager.has_signal("coins_updated"):
			manager.coins_updated.connect(_update_coin_display)
		if manager.has_method("get_coins"):
			_update_coin_display(manager.get_coins())

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("pause"):
		toggle_pause_menu()

func toggle_pause_menu() -> void:
	is_paused = not is_paused
	get_tree().paused = is_paused
	if pause_overlay:
		pause_overlay.visible = is_paused

func _on_resume_pressed() -> void:
	toggle_pause_menu()

func _update_coin_display(new_total: int) -> void:
	if coin_label:
		coin_label.text = "Coins: " + str(new_total)

func update_health(new_health: int) -> void:
	if health_bar:
		health_bar.value = clamp(new_health, 0, 100)

func _on_sound_toggle_toggled(button_pressed: bool) -> void:
	var manager = get_node_or_null("/root/Manager")
	if manager and "on" in manager:
		manager.on = button_pressed