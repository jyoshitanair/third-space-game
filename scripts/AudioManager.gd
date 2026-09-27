extends Node

@export var sfx_volume_db: float = -6.0
@export var music_volume_db: float = -14.0

var bgm_player: AudioStreamPlayer
var sfx_pool: Array[AudioStreamPlayer] = []
const POOL_SIZE: int = 5

# Preloading main game loop track from assets
var main_theme = preload("res://assets/music/loop.ogg")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_init_audio_channels()
	play_default_music()

func _init_audio_channels() -> void:
	bgm_player = AudioStreamPlayer.new()
	bgm_player.volume_db = music_volume_db
	add_child(bgm_player)

	for i in range(POOL_SIZE):
		var p = AudioStreamPlayer.new()
		p.volume_db = sfx_volume_db
		add_child(p)
		sfx_pool.append(p)

func play_default_music() -> void:
	if main_theme:
		play_music(main_theme)

func play_music(stream: AudioStream) -> void:
	if bgm_player.stream == stream and bgm_player.playing:
		return
	bgm_player.stream = stream
	bgm_player.play()

func play_sfx(stream: AudioStream) -> void:
	if stream == null:
		return
	for p in sfx_pool:
		if not p.playing:
			p.stream = stream
			p.play()
			return

func stop_all() -> void:
	bgm_player.stop()
	for p in sfx_pool:
		p.stop()
