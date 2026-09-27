extends Node
var level = 1
var first = true 
var health = 100
var paused = false
var coins = 6000
var cloth1 = false
var cloth2 = false
var pet = false
var volume = 10
var on = true

##music
var music
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("_talo_setup")
	music = AudioStreamPlayer.new()
	add_child(music)
	music.autoplay = false
	music.stream = preload("res://assets/music/loop.ogg")
	music.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	music.volume_db = volume
	if !music.playing and music:
		music.play()
	if !on:
		music.stop()
func _talo_setup() -> void: 
	Talo.settings.access_key= Secrets.TALO_PLAYER_API
