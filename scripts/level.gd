extends Node2D
var level = 1
var end = 2
var player = preload("res://scenes/player.tscn")
@onready var spawn: Marker2D = $spawn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var preal = player.instantiate()
	get_tree().current_scene.add_child.call_deferred(preal)
	preal.global_position = spawn.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _change_level() -> void: 
	if level >= end:
		get_tree().change_scene_to_file("main");
	else:
		var new_level = "Level_%d"%level
		get_tree().change_scene_to_file(new_level);
