extends Node2D

signal verification_required
signal go_to_forgot_password
signal go_to_register

@onready var username: TextEdit = %Username
@onready var password: TextEdit = %Password
@onready var validation_label: Label = %ValidationLabel

func _on_submit_pressed() -> void:
	validation_label.text = ""

	if not username.text:
		validation_label.text = "Username is required"
		return

	if not password.text:
		validation_label.text = "Password is required"
		return

	var res := await Talo.player_auth.login(username.text, password.text)
	if not res.success:
		match res.error.code:
			TaloPlayerAuthError.ErrorCode.INVALID_CREDENTIALS:
				validation_label.text = "Username or password is incorrect"
			_:
				validation_label.text = res.error.message
	else:
		Talo.current_player.set_prop("coins", "0")
		Talo.current_player.set_prop("level", "1")
		Talo.current_player.set_prop("cloth1", "false")
		Talo.current_player.set_prop("cloth2", "false")
		Talo.current_player.set_prop("pet", "false")
		get_tree().change_scene_to_file("res://scenes/title.tscn")

func _on_register_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/talo/samples/authentication/states/register.tscn")
