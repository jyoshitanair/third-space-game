extends Node2D

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
	if Manager.level >= end:
		queue_free()
	else:
		var new_path = "res://scenes/level%d.tscn"%Manager.level
		get_tree().current_scene.add_child(new_path)
func _on_end_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_change_level()
