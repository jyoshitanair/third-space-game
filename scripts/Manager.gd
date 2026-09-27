extends Node
##STUFF TO PUSH TO TALO!
var level = 1 
var health = 100
var coins = 6000
var cloth1 = false
var cloth2 = false
var pet = false

##OTHER STUFF
var first = true
var paused = false
var volume = 10
var on = true
var namey = ""
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
	
func _coin_change() -> void: 
	coins += 1
	Talo.current_player.set_prop("coins", coins)
func _level_change() -> void: 
	if level != 6:
		level += 1
	Talo.current_player.set_prop("level", level)
func _cloth1_got() -> void: 
	cloth1 = true
	Talo.current_player.set_prop("cloth1", "true")
func _cloth2_got() -> void: 
	cloth2 = true
	Talo.current_player.set_prop("cloth2", "true")
func _pet_got() -> void: 
	pet = true
	Talo.current_player.set_prop("pet", "true")
