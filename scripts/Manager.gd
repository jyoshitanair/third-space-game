extends Node
var level = 1
var first = true 
var health = 100
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		#
	var config = {
		"api_key": Secrets.SILENT_WOLF_API_KEY,
		"game_id": "third-space",
		"log_level": 0
	}

	var scores_config = {
		"open_scene_on_close": "res://scenes/Splash.tscn"
	}

	var auth_config = {
		"redirect_to_scene": "res://scenes/title.tscn",
		"login_scene": "res://addons/silent_wolf/Auth/Login.tscn",
		#"email_confirmation_scene": "res://addons/silent_wolf/Auth/ConfirmEmail.tscn",
		"reset_password_scene": "res://addons/silent_wolf/Auth/ResetPassword.tscn",
		"session_duration_seconds": 0,
		"saved_session_expiration_days": 30
	}
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
