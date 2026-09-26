extends Node2D

var end = 2
var player = preload("res://scenes/player.tscn")
@onready var spawn: Marker2D = $spawn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("LOADING PLATER")
	var preal = player.instantiate()
	print(spawn)
	if Manager.first:
		get_tree().current_scene.add_child.call_deferred(preal)
		Manager.first = false
	else:
		print("HALLO?")
		get_tree().current_scene.add_child(preal)
	preal.global_position = spawn.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _change_level(new_node) -> void: 
	get_tree().current_scene.add_child(new_node)
	queue_free()
func _on_end_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if Manager.level >= end:
			queue_free()
		else:
			Manager.level += 1
			var new_path = "res://scenes/level%d.tscn"%Manager.level
			var new_level = load(new_path)
			var new_node = new_level.instantiate()
			get_tree().get_first_node_in_group("player").queue_free()
			call_deferred("_change_level", new_node)
