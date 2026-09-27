extends Node2D

signal go_to_login

@onready var username: TextEdit = %Username
@onready var password: TextEdit = %Password
@onready var validation_label: Label = %ValidationLabel

func _on_submit_button_pressed() -> void:
	validation_label.text = ""

	if not username.text:
		validation_label.text = "Username is required"
		return

	if not password.text:
		validation_label.text = "Password is required"
		return

	var res := await Talo.player_auth.register(username.text, password.text, "", false)
	if not res.success:
		match res.error.code:
			TaloPlayerAuthError.ErrorCode.IDENTIFIER_TAKEN:
				validation_label.text = "Username is already taken"
			TaloPlayerAuthError.ErrorCode.INVALID_EMAIL:
				validation_label.text = "Invalid email address"
			_:
				validation_label.text = res.error.message
	else:
		get_tree().change_scene_to_file("res://addons/talo/samples/authentication/states/login.tscn")

func _on_login_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/talo/samples/authentication/states/login.tscn")
