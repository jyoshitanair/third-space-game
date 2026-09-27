extends Node

## STUFF TO PUSH TO TALO
var level: int = 1
var health: int = 100
var coins: int = 6000
var cloth1: bool = false
var cloth2: bool = false
var pet: bool = false
##NEED TO DO THIS NEXT WEEK!!!
var level_coins:int = 0
var c1_enabled:bool = false
var c2_enabled:bool = false
var pet_enabled:bool = false
## OTHER STUFF
var first: bool = true
var paused: bool = false
var volume: float = 10.0
var on: bool = true
var namey: String = ""

## AUDIO & BACKEND STATE
var music: AudioStreamPlayer
var is_backend_active: bool = false

func _ready() -> void:
	call_deferred("_talo_setup")
	_init_audio_system()

func _init_audio_system() -> void:
	music = AudioStreamPlayer.new()
	add_child(music)
	music.autoplay = false
	var bgm_path = "res://assets/music/loop.ogg"
	if ResourceLoader.exists(bgm_path):
		music.stream = load(bgm_path)
		if on:
			music.play()

func _process(_delta: float) -> void:
	if not music:
		return
	music.volume_db = volume
	if on and not music.playing:
		music.play()
	elif not on and music.playing:
		music.stop()

func _talo_setup() -> void:
	if has_node("/root/Talo") and Talo.settings and Talo.settings.access_key != "":
		is_backend_active = true
	else:
		print("Offline mode: Talo backend sync disabled")
		is_backend_active = false

func _sync_talo_prop(prop_name: String, val) -> void:
	if is_backend_active and Talo.current_player:
		Talo.current_player.set_prop(prop_name, str(val))

func _coin_change(amount: int = 1) -> void:
	coins += amount
	_sync_talo_prop("coins", coins)

func _level_change() -> void:
	if level != 6:
		level += 1
	_sync_talo_prop("level", level)

func _cloth1_got() -> void:
	cloth1 = true
	_sync_talo_prop("cloth1", "true")

func _cloth2_got() -> void:
	cloth2 = true
	_sync_talo_prop("cloth2", "true")

func _pet_got() -> void:
	pet = true
	_sync_talo_prop("pet", "true")
