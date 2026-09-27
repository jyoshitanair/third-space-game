extends Node2D
@onready var username: TextEdit = $Control/username
@onready var password: TextEdit = $Control/password
@onready var label: Label = $Control/Label2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_register_pressed() -> void:
	if username.text.strip_edges() != "" and password.text.strip_edges() != "":
		var res := await Talo.player_auth.register(username.text, password.text, "", false)
		if not res.success:
			match res.error.code:
				TaloPlayerAuthError.ErrorCode.IDENTIFIER_TAKEN:
					label.text = "Username is taken"
				TaloPlayerAuthError.ErrorCode.IDENTIFIER_PROFANITY:
					label.text = "uhhh lets ...not say that"
				_:
					label.text = res.error.message
		else:
			label.text = "alrighty. lets fill in stuff :/"
		
