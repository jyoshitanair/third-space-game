extends Control

@onready var username_input: LineEdit = $username
@onready var password_input: LineEdit = $password
@onready var status_label: Label = $Label
@onready var submit_btn: Button = $Submit

var is_authenticating: bool = false

func _ready() -> void:
	_bind_ui_signals()
	_validate_backend_credentials()

func _bind_ui_signals() -> void:
	if submit_btn and not submit_btn.pressed.is_connected(_on_register_pressed):
		submit_btn.pressed.connect(_on_register_pressed)

func _validate_backend_credentials() -> bool:
	if not Talo or not Talo.settings or not Talo.settings.access_key:
		print("API Key missing or invalid. Initializing fallback mode.")
		return false
	return true

func _on_register_pressed() -> void:
	if is_authenticating:
		return

	var u_text = username_input.text.strip_edges() if username_input else ""
	var p_text = password_input.text.strip_edges() if password_input else ""

	if u_text.is_empty() or p_text.is_empty():
		_update_status("Please enter both username and password")
		return

	# Fallback to local session if backend secrets are absent
	if not _validate_backend_credentials():
		_update_status("Connecting as local profile...")
		get_tree().change_scene_to_file("res://scenes/all_levels.tscn")
		return

	is_authenticating = true
	_update_status("Registering account...")
	var res = await Talo.player_auth.register(u_text, p_text)

	if res and res.success:
		get_tree().change_scene_to_file("res://scenes/all_levels.tscn")
	else:
		is_authenticating = false
		var err_msg = res.error.message if res and res.error else "Registration failed"
		_update_status(str(err_msg))

func _update_status(msg: String) -> void:
	if status_label:
		status_label.text = msg

func _on_submit_pressed() -> void:
	_on_register_pressed()

func _on_button_pressed() -> void:
	_on_register_pressed()

func _on_go_to_login_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title.tscn")
