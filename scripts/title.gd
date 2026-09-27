extends Node2D

func _ready() -> void:
	SilentWolf.Auth.sw_session_check_complete.connect(_on_login_complete)
	SilentWolf.Auth.sw_login_complete.connect(_on_login_complete)
	SilentWolf.Auth.auto_login_player()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/silent_wolf/Auth/Login.tscn")

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/silent_wolf/Auth/Register.tscn")
func _on_login_complete(sw_result):
	update_login_state_label()
func update_login_state_label():
	if SilentWolf.Auth.logged_in_player:
		print("logged in")
	else:
		print("not logged in")
