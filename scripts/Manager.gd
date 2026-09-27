extends Node
##STUFF TO PUSH TO TALO!
var level = 1 
var health = 100
var coins: int = 6000
var cloth1 = false
var cloth2 = false
var pet = false
var level_coins = 0
##NEED TO DO THIS NEXT WEEK!!!
var c1_enabled = false
var c2_enabled = false
var pet_enabled = false
##OTHER STUFF
var first = true
var paused = false
var volume = 10
var on = true
var namey = ""
##music
var music
##MOOSIC
var tracks = {
	"vocaloid": preload("res://assets/music/chrisdjyogi-vocaloid-electroswing-noir-creepy-alt-pop-439236.mp3"),
	"water": preload("res://assets/music/kontraa-water-afro-pop-music-445661.mp3"),
	"normal": preload("res://assets/music/normal.ogg"),
	"underwater": preload("res://assets/music/igorovsyannykov-underwater-audiopanther-311437.mp3"),
	"loop": preload("res://assets/music/loop.ogg"),
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("_talo_setup")
	music = AudioStreamPlayer.new()
	add_child(music)
	music.autoplay = false
	_change_music("normal")
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
func _change_music(track) -> void: 
	if tracks.has(track):
		music.stream = tracks[track]
	else:
		print("where my track at")
func _coin_change() -> void: 
	coins += 1
	Talo.current_player.set_prop("coins", str(coins))
func _level_change() -> void: 
	if level != 6:
		level += 1
	Talo.current_player.set_prop("level", str(level))
func _cloth1_got() -> void: 
	cloth1 = true
	Talo.current_player.set_prop("cloth1", "true")
func _cloth2_got() -> void: 
	cloth2 = true
	Talo.current_player.set_prop("cloth2", "true")
func _pet_got() -> void: 
	pet = true
	Talo.current_player.set_prop("pet", "true")
