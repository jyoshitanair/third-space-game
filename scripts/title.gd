extends Node2D
@onready var noob: Node2D = $Control/noob
@onready var pro: Node2D = $Control/pro
@onready var label: Label = $Control/pro/Label
@onready var i_tink: Label = $Label

func _ready() -> void:
	Talo.players.identified.connect(_on_player_identified)
	Talo.player_auth.session_found.connect(_on_verified)
	Talo.player_auth.session_not_found.connect(_on_not_verified)
	# identified signal emitted before the connection were made
	if Talo.current_alias:
		_on_player_identified(Talo.current_alias)
	Talo.player_auth.start_session()
func _on_verified() -> void: 
	pro.show()
	i_tink.hide()
	print("FOUND")
func _on_not_verified() -> void: 
	noob.show()
	i_tink.hide()
	print("NOT FOUND")
func _on_player_identified(player_alias: TaloPlayerAlias) -> void:
	label.text = "hihi,\n%s?" % player_alias.identifier
	var coins := Talo.current_player.get_prop("coins", "0")
	var level := Talo.current_player.get_prop("level", "1")
	var cloth1 := Talo.current_player.get_prop("cloth1", "false")
	var cloth2 := Talo.current_player.get_prop("cloth2", "false")
	var pet := Talo.current_player.get_prop("pet", "false")
	print("pet", pet)
	print("level", level)
	print("cloth1", cloth1)
	print("cloth2", cloth2)
	print("coins", coins)
	Manager.namey = player_alias.identifier
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/talo/samples/authentication/states/login.tscn")
func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/talo/samples/authentication/states/register.tscn")


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
